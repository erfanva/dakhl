# Dakhl — build plan and status

Persian, Android-only, fully local personal finance app. No backend, no
account, no network calls. The distinguishing feature is that incoming Iranian
bank SMS are parsed automatically — even with the app closed — and surfaced as
a notification that opens a one-tap categorization sheet.

This file is the running plan: what each phase covers, what is actually built,
and the decisions worth not re-litigating. Code, comments and docs are English;
only UI strings are Persian.

## Status

| Phase | Scope | Status |
|---|---|---|
| 1 | Manual transactions, Jalali-grouped ledger | ✅ done |
| 2 | Accounts with computed balances, categories, charts | ✅ done |
| 3 | Bank SMS detection → notification → categorize sheet | ✅ done |
| 4 | Recurring income/expenses, debts & credits, reminders | ✅ done |
| 5 | Budgets, wishes, commitment score | next |

Gate for "done": `flutter analyze` clean, `flutter test` green, and the debug
APK builds. Phase 4 additionally builds and installs but has **not** been
exercised on a real device yet (see [Open items](#open-items)).

## Invariants

These hold across every phase; breaking one is a bug, not a design choice.

- **Money is integer Rial** in the database everywhere. The display unit
  (Toman by default) is applied only at the presentation layer, in
  `lib/core/money/money.dart`.
- **Dates are Gregorian epoch instants**, with denormalized `jYear`/`jMonth`
  columns on rows that get grouped by month — so monthly queries are plain
  indexed `GROUP BY`s rather than per-row conversions.
- **Pending SMS transactions are a `status` on `transactions`**, not a separate
  table. One query drives both the inbox and the ledger.
- **A recurring item is a schedule, an occurrence is one month of it, and a
  transaction is the money.** Nothing settles an occurrence without writing the
  transaction behind it, in the same database transaction.
- **Notification id spaces must not overlap.** Pending-transaction alerts use
  the transaction's own id; reminders are offset by
  `ReminderScheduler.idBase` (1,000,000).
- **Plugin receivers are the app's job.** Both `another_telephony` and
  `flutter_local_notifications` ship no receivers in their own manifests, so
  `android/app/src/main/AndroidManifest.xml` declares them. Every failure mode
  here is silent.

## Phase 1 — manual transactions ✅

Drift schema for the whole app (all five phases' tables exist from the start,
so there is no migration debt), Jalali month utilities, Persian digit and
amount formatting, the transactions tab with a month switcher and day-grouped
list, and the add/edit sheet.

Key files: `lib/core/db/tables.dart`, `lib/core/persian/`,
`lib/core/money/`, `lib/features/transactions/`.

## Phase 2 — accounts, categories, reports ✅

- Accounts with **computed** balances: initial balance + confirmed deposits −
  confirmed withdrawals. Nothing stores a running balance, so nothing can
  drift out of step with the ledger.
- Deleting an account or a category never deletes transactions — the foreign
  keys are `ON DELETE SET NULL`, so rows just lose their account/category.
- System categories (`uncategorized`, `debt_payment`, `credit_received`,
  `balance_adjustment`, `self_transfer`) are seeded with stable `systemKey`s
  and cannot be deleted; code looks them up by key, never by name.
- Reports: month summary, 6-month income/expense trend, per-category
  breakdown, and a category detail page.

Key files: `lib/core/db/daos/accounts_dao.dart`,
`lib/core/db/seed_categories.dart`, `lib/features/reports/`.

## Phase 3 — bank SMS detection ✅

- `SmsPipeline.handle` is the **single entry point**: the background broadcast
  handler and the debug injector both call it, so what is tested at a desk is
  what runs on a real message.
- The parser is **pattern-driven and stored in the database**, seeded with nine
  Iranian banks plus a generic fallback. A new SMS format is a settings edit,
  not a release. Regexes are validated before saving — a malformed one would
  otherwise throw inside the background isolate where nobody would see it.
- Transaction direction comes from whichever keyword appears **earliest** in
  the body: these messages routinely contain both «واریز» and «برداشت», and the
  leading verb is the reliable one.
- Background delivery depends on four device-level conditions that all fail
  silently, so the app reports them itself: SMS permission, notification
  permission, battery optimisation, and OEM autostart. Autostart has no
  readable API, so the app opens the vendor screen (a `resolveActivity` chain
  across Xiaomi, Huawei, Oppo, Vivo and others) and takes the user's word via a
  checkbox. Only the two hard blockers force the setup screen on launch; the
  banner keeps offering the rest and cannot be dismissed.

Key files: `lib/core/sms/`, `lib/core/setup/device_setup.dart`,
`lib/features/setup/`, `lib/features/pending/`.

## Phase 4 — recurring, debts, reminders ✅

### Recurring income and expenses

`lib/core/db/daos/recurring_dao.dart` + `lib/features/month_plan/`.

- `RecurringIncomes` and `RecurringExpenses` share `RecurringColumns` and
  differ only in direction, so a single `RecurringItem` read model is built
  from either table. Nothing downstream branches on which table a row is in.
  The kind is fixed at creation — a salary cannot become a bill.
- Occurrences are **materialized lazily**: `watchMonthPlan` materializes the
  month it is watching, so opening a month (or adding an item while looking at
  one) fills it in. `materialize` writes **nothing** when nothing is missing —
  a write would notify drift, re-trigger the stream, and spin forever.
- `main.dart` also materializes the current and next month at launch, because
  reminders are scheduled off occurrences and must not depend on whether the
  user visited a tab.
- Day-of-month is clamped per month: the 31st lands on the 30th of a 30-day
  month, and on Esfand's 29th/30th. Editing the day moves only **unsettled**
  occurrences; a settled one keeps the date the money actually moved.
- Settling writes the transaction (`TxnSource.recurring`) and links it, in one
  database transaction. Reopening deletes that transaction — leaving it behind
  would double-count the month. A month whose amount differed is recorded as an
  `amountOverrideRial` only when it really differs, so the occurrence keeps
  following later edits to the item's default.
- Skipping is "not this month": no transaction, and excluded from plan totals.

### Debts and credits

`lib/core/db/daos/debts_dao.dart` + `lib/features/debts/`.

- Payments write a real transaction with the right direction and system
  category: paying what I owe is a withdrawal against `debt_payment`;
  collecting what I'm owed is a deposit against `credit_received`. A
  "don't record in the ledger" switch exists for payments the user already
  entered by hand.
- Crossing the total settles the debt automatically; deleting a payment
  reopens it. Overpaying settles rather than flipping the sign into a credit.
- The list stream is driven off a change-watch over `debts` **and**
  `debt_payments`: a partial payment doesn't touch the debt row, and the list
  still has to move.
- Deleting a debt cascades its payments and drops its reminder rules, but
  leaves the generated transactions in the ledger — that money really moved.

### Reminders

`lib/core/notifications/reminder_scheduler.dart`,
`lib/core/db/daos/reminders_dao.dart`, `lib/features/reminders/`.

- Rules are "remind me N days before, at HH:MM", many per owner. **No rules
  means no reminders** — that is how the feature is turned off, so a new item
  gets a real default row (on the due date, 09:00) rather than an implicit
  fallback.
- `sync()` is a **diff** against `scheduled_notifications`, not a rebuild, so
  it can run on every launch and every edit without resetting alarms the user
  is already waiting on. It is driven reactively by `reminderSyncProvider`,
  held for the whole session by `DakhlApp`.
- A row whose fire time has passed is **forgotten, not cancelled** —
  cancelling would clear the notification out of the tray the user is looking
  at.
- Exact alarms are requested and then done without: Android 13+ may refuse
  `SCHEDULE_EXACT_ALARM`, and a reminder that slips half an hour beats one that
  throws. Falls back to `inexactAllowWhileIdle`.
- Horizon is 62 days, because Android caps how many alarms an app may hold and
  anything further out gets scheduled on a later launch anyway.
- Timezone is fixed to `Asia/Tehran` rather than read from the device — Dakhl
  is Iran-only, and reading it would mean another plugin for no practical gain.
- Tapping a reminder deep-links via `NotificationPayload.route`. Modal routes
  (the categorize sheet) are pushed so they can be popped; tab destinations are
  navigated to, or the shell ends up stacked on itself.

### Phase 4 tidy-ups

- `MonthSwitcher` was duplicated in the transactions and reports pages; it now
  lives in `lib/shared/ui/month_switcher.dart` and tapping the month label
  returns to the current month.
- The month-plan tab carries a badge for overdue occurrences, so an unpaid
  fixed expense is visible without opening the tab.

## Phase 5 — budgets, wishes, commitment score (next)

Schema already exists: `Budgets`, `Wishes`, `WishLinks`, `WishImages`.

1. **Budgets.** Per-category monthly caps plus an optional overall cap
   (`categoryId == null`), unique per `(jYear, jMonth, categoryId)`. Needs a
   DAO joining caps against `watchCategoryTotals`, a budgets section on the
   month plan tab, and a copy-last-month action so setting caps isn't monthly
   data entry. Open question: whether an over-cap category should notify, and
   if so whether it reuses the reminders channel.
2. **Wishes.** Title, description, optional target date and estimated cost,
   ordered, with links and images (`image_picker` and `path_provider` are
   already dependencies; images are stored relative to the app documents
   directory). Reachable from the "More" tab, where the entry is currently
   disabled with a «به‌زودی» subtitle.
3. **Commitment score.** A monthly figure over: budget adherence, share of
   transactions properly categorized (excluding
   `SystemCategoryKeys.uncountedForScore`), and settled-on-time share of
   recurring occurrences and debts. The score's definition is the real work
   here — the inputs all exist. It belongs on the reports tab.

## Open items

- **Phase 4 has not been run on a device.** Analyze, tests and the debug APK
  build all pass, but real reminder firing — especially under MIUI's power
  manager — is only knowable by hand. Wireless debugging pairing is the current
  blocker.
- `lib/features/reports/ui/placeholder_reports_page.dart` was orphaned when the
  real reports page landed in Phase 2; it is referenced by nothing.
- Schema is still `schemaVersion` 1 with no migrations, which is fine only
  while the app is unreleased. The first release freezes that: any table change
  after it needs a migration step.
