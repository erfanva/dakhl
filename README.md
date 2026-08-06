# دخل (Dakhl)

Persian, Android-only personal finance app for tracking monthly income and expenses.
Fully local — no backend, no account, no network calls.

The distinguishing feature: incoming Iranian bank SMS messages are parsed
automatically (even when the app is closed) and surfaced as a notification that
opens a one-tap categorization sheet.

## Features

| Area | Status |
|---|---|
| Manual transactions, Jalali-grouped ledger | ✅ Phase 1 |
| Accounts with computed balances, categories, charts | Phase 2 |
| Bank SMS detection → notification → categorize sheet | Phase 3 |
| Recurring income/expenses, debts & credits, reminders | Phase 4 |
| Budgets, wishes, commitment score | Phase 5 |

## Conventions

- **Money is stored as integer Rial** everywhere in the database; the display
  unit (Toman by default) is applied only at the presentation layer via
  `lib/core/money/money.dart`.
- **Dates are stored as Gregorian epoch instants**, with denormalized
  `jYear`/`jMonth` columns on rows that get grouped by month, so monthly
  queries are plain indexed `GROUP BY`s.
- **UI strings are Persian; code, comments, and docs are English.**
- Pending SMS transactions are a `status` on `transactions`, not a separate
  table — one query drives both the inbox and the ledger.

## Development

```bash
flutter pub get
dart run build_runner build    # regenerate Drift/database code
flutter test
flutter run
```

Drift's generated `*.g.dart` files are committed, so a plain `flutter run`
works without a codegen step; rerun `build_runner` after touching anything in
`lib/core/db/`.

## Environment notes

- Requires a full JDK (with `javac`) — configured via `flutter config --jdk-dir`.
- Gradle needs proxy settings in `android/gradle.properties`; it does not read
  the `HTTP_PROXY` environment variable. After changing them, run
  `./gradlew --stop` so stale daemons pick up the new values.
- `permission_handler` is pinned to 12.x because 13's Android implementation
  requires `compileSdk 37`, which the bundled Android Gradle Plugin caps below.
- Core library desugaring is enabled for `flutter_local_notifications`.
