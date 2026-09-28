import 'package:drift/drift.dart';

import '../../persian/jalali_utils.dart';
import '../database.dart';

part 'recurring_dao.g.dart';

/// A recurring income or expense, read out of whichever of the two tables
/// it happens to live in.
///
/// The tables share [RecurringColumns] and differ only in direction, so every
/// query, form and list works against this one shape instead of branching on
/// a union of two generated row classes.
class RecurringItem {
  const RecurringItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.amountRial,
    required this.jDay,
    required this.start,
    required this.isActive,
    required this.createdAt,
    this.end,
    this.categoryId,
    this.accountId,
    this.note,
  });

  factory RecurringItem.fromIncome(RecurringIncome row) => RecurringItem(
        id: row.id,
        kind: OwnerKind.recurringIncome,
        title: row.title,
        amountRial: row.amountRial,
        jDay: row.jDay,
        start: JalaliMonth(row.startJYear, row.startJMonth),
        end: _monthOrNull(row.endJYear, row.endJMonth),
        isActive: row.isActive,
        createdAt: row.createdAt,
        categoryId: row.categoryId,
        accountId: row.accountId,
        note: row.note,
      );

  factory RecurringItem.fromExpense(RecurringExpense row) => RecurringItem(
        id: row.id,
        kind: OwnerKind.recurringExpense,
        title: row.title,
        amountRial: row.amountRial,
        jDay: row.jDay,
        start: JalaliMonth(row.startJYear, row.startJMonth),
        end: _monthOrNull(row.endJYear, row.endJMonth),
        isActive: row.isActive,
        createdAt: row.createdAt,
        categoryId: row.categoryId,
        accountId: row.accountId,
        note: row.note,
      );

  final int id;

  /// Always [OwnerKind.recurringIncome] or [OwnerKind.recurringExpense].
  final OwnerKind kind;
  final String title;
  final int amountRial;

  /// Day of the Jalali month; clamped per month when an occurrence is made.
  final int jDay;
  final JalaliMonth start;

  /// Inclusive last month, or null for "until I turn it off".
  final JalaliMonth? end;
  final bool isActive;
  final DateTime createdAt;
  final int? categoryId;
  final int? accountId;
  final String? note;

  bool get isIncome => kind == OwnerKind.recurringIncome;

  TxnType get txnType => isIncome ? TxnType.deposit : TxnType.withdrawal;

  /// Whether [month] falls inside this item's active range.
  bool coversMonth(JalaliMonth month) {
    if (month.ordinal < start.ordinal) return false;
    final last = end;
    return last == null || month.ordinal <= last.ordinal;
  }

  /// When this month's instance falls due, with the day clamped to the
  /// month's length (the 31st becomes the 30th, or Esfand's 29th/30th).
  DateTime dueDateIn(JalaliMonth month) =>
      JalaliUtils.dateForDayOfMonth(month, jDay);

  static JalaliMonth? _monthOrNull(int? year, int? month) =>
      (year == null || month == null) ? null : JalaliMonth(year, month);
}

/// The values a recurring item is created or edited with — one shape for
/// income and expense, so a single form serves both.
class RecurringDraft {
  const RecurringDraft({
    required this.kind,
    required this.title,
    required this.amountRial,
    required this.jDay,
    required this.start,
    this.end,
    this.categoryId,
    this.accountId,
    this.note,
    this.isActive = true,
  });

  final OwnerKind kind;
  final String title;
  final int amountRial;
  final int jDay;
  final JalaliMonth start;
  final JalaliMonth? end;
  final int? categoryId;
  final int? accountId;
  final String? note;
  final bool isActive;
}

/// One month's instance of a recurring item, joined with the item itself and
/// its category — everything a row on the month plan needs to render.
class PlannedEntry {
  const PlannedEntry({
    required this.item,
    required this.occurrence,
    this.category,
  });

  final RecurringItem item;
  final RecurringOccurrence occurrence;
  final Category? category;

  /// The amount this month, which may differ from the recurring default
  /// (a variable utility bill, say).
  int get amountRial => occurrence.amountOverrideRial ?? item.amountRial;

  DateTime get dueAt => occurrence.dueAt;
  OccurrenceStatus get status => occurrence.status;
  bool get isDone => status == OccurrenceStatus.done;
  bool get isSkipped => status == OccurrenceStatus.skipped;
  bool get isDue => status == OccurrenceStatus.due;

  /// A due date in the past that nobody has settled or skipped.
  bool isOverdue(DateTime now) => isDue && dueAt.isBefore(now);
}

/// The plan for one Jalali month: what is supposed to happen (occurrences)
/// next to what actually did (the ledger).
class MonthPlan {
  const MonthPlan({
    required this.month,
    required this.incomes,
    required this.expenses,
    required this.actualIncomeRial,
    required this.actualExpenseRial,
  });

  final JalaliMonth month;

  /// Both lists are ordered by due date.
  final List<PlannedEntry> incomes;
  final List<PlannedEntry> expenses;

  /// Confirmed ledger totals for the month, from every source — the reality
  /// the plan is measured against.
  final int actualIncomeRial;
  final int actualExpenseRial;

  bool get isEmpty => incomes.isEmpty && expenses.isEmpty;

  /// Skipped entries are excluded everywhere: skipping is the user saying
  /// "not this month", so it should not inflate the plan.
  int get plannedIncomeRial => _sum(incomes);
  int get plannedExpenseRial => _sum(expenses);
  int get plannedNetRial => plannedIncomeRial - plannedExpenseRial;

  int get settledIncomeRial => _sum(incomes, status: OccurrenceStatus.done);
  int get settledExpenseRial => _sum(expenses, status: OccurrenceStatus.done);

  int get outstandingIncomeRial => _sum(incomes, status: OccurrenceStatus.due);
  int get outstandingExpenseRial => _sum(expenses, status: OccurrenceStatus.due);

  /// Sums [entries], counting only rows in [status] — or, when no status is
  /// given, everything the user hasn't skipped.
  int _sum(List<PlannedEntry> entries, {OccurrenceStatus? status}) {
    var total = 0;
    for (final entry in entries) {
      final counts = status == null ? !entry.isSkipped : entry.status == status;
      if (counts) total += entry.amountRial;
    }
    return total;
  }
}

@DriftAccessor(tables: [
  RecurringIncomes,
  RecurringExpenses,
  RecurringOccurrences,
  ReminderRules,
  Transactions,
  Categories,
])
class RecurringDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringDaoMixin {
  RecurringDao(super.db);

  Stream<List<RecurringItem>> watchItems({
    OwnerKind? kind,
    bool includeInactive = false,
  }) {
    return _planChanges().asyncMap(
      (_) => readItems(kind: kind, includeInactive: includeInactive),
    );
  }

  /// Every recurring item, income and expense together, ordered by day of
  /// month so the caller can render them in the order they fall due.
  Future<List<RecurringItem>> readItems({
    OwnerKind? kind,
    bool includeInactive = false,
  }) async {
    final items = <RecurringItem>[];

    if (kind != OwnerKind.recurringExpense) {
      final query = select(recurringIncomes);
      if (!includeInactive) query.where((r) => r.isActive.equals(true));
      items.addAll((await query.get()).map(RecurringItem.fromIncome));
    }
    if (kind != OwnerKind.recurringIncome) {
      final query = select(recurringExpenses);
      if (!includeInactive) query.where((r) => r.isActive.equals(true));
      items.addAll((await query.get()).map(RecurringItem.fromExpense));
    }

    items.sort((a, b) => a.jDay.compareTo(b.jDay));
    return items;
  }

  Future<RecurringItem?> findItem(OwnerKind kind, int id) async {
    if (kind == OwnerKind.recurringIncome) {
      final row = await (select(recurringIncomes)..where((r) => r.id.equals(id)))
          .getSingleOrNull();
      return row == null ? null : RecurringItem.fromIncome(row);
    }
    final row = await (select(recurringExpenses)..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : RecurringItem.fromExpense(row);
  }

  /// Inserts a new item. Its occurrences are created by [materialize], which
  /// the plan stream runs for whichever month is on screen.
  Future<int> insertItem(RecurringDraft draft) {
    final createdAt = DateTime.now();
    return draft.kind == OwnerKind.recurringIncome
        ? into(recurringIncomes).insert(_incomeCompanion(draft, createdAt: createdAt))
        : into(recurringExpenses)
            .insert(_expenseCompanion(draft, createdAt: createdAt));
  }

  /// Applies [draft] to an existing item. The kind is fixed at creation —
  /// a salary cannot become a bill — so [draft]'s kind must match.
  Future<void> updateItem(int id, RecurringDraft draft) {
    return transaction(() async {
      if (draft.kind == OwnerKind.recurringIncome) {
        await (update(recurringIncomes)..where((r) => r.id.equals(id)))
            .write(_incomeCompanion(draft));
      } else {
        await (update(recurringExpenses)..where((r) => r.id.equals(id)))
            .write(_expenseCompanion(draft));
      }
      await _refreshDueDates(draft.kind, id, draft.jDay);
    });
  }

  Future<void> setActive(OwnerKind kind, int id, bool isActive) {
    if (kind == OwnerKind.recurringIncome) {
      return (update(recurringIncomes)..where((r) => r.id.equals(id)))
          .write(RecurringIncomesCompanion(isActive: Value(isActive)));
    }
    return (update(recurringExpenses)..where((r) => r.id.equals(id)))
        .write(RecurringExpensesCompanion(isActive: Value(isActive)));
  }

  /// Deletes an item along with its occurrences and reminder rules. Those
  /// reference the item by (kind, id) rather than a foreign key, so nothing
  /// cascades on its own.
  ///
  /// Transactions already generated by past occurrences are left alone: that
  /// money really moved, and deleting the schedule shouldn't rewrite history.
  Future<void> deleteItem(OwnerKind kind, int id) {
    return transaction(() async {
      await (delete(recurringOccurrences)
            ..where((o) => o.ownerKind.equalsValue(kind) & o.ownerId.equals(id)))
          .go();
      await (delete(reminderRules)
            ..where((r) => r.ownerKind.equalsValue(kind) & r.ownerId.equals(id)))
          .go();
      if (kind == OwnerKind.recurringIncome) {
        await (delete(recurringIncomes)..where((r) => r.id.equals(id))).go();
      } else {
        await (delete(recurringExpenses)..where((r) => r.id.equals(id))).go();
      }
    });
  }

  /// Creates the `due` occurrence of [month] for every active item that
  /// covers it, and returns how many it created.
  ///
  /// Writes nothing when there is nothing missing. That matters more than it
  /// looks: [watchMonthPlan] materializes on every emission, so a call that
  /// wrote unconditionally would notify drift, re-trigger the stream, and
  /// spin forever.
  Future<int> materialize(JalaliMonth month) async {
    final covering = (await readItems())
        .where((item) => item.coversMonth(month))
        .toList();
    if (covering.isEmpty) return 0;

    final existing = await (select(recurringOccurrences)
          ..where((o) =>
              o.jYear.equals(month.year) & o.jMonth.equals(month.month)))
        .get();
    final present = {
      for (final occurrence in existing)
        (occurrence.ownerKind, occurrence.ownerId),
    };
    final missing = covering
        .where((item) => !present.contains((item.kind, item.id)))
        .toList();
    if (missing.isEmpty) return 0;

    await batch((batch) {
      for (final item in missing) {
        batch.insert(
          recurringOccurrences,
          RecurringOccurrencesCompanion.insert(
            ownerKind: item.kind,
            ownerId: item.id,
            jYear: month.year,
            jMonth: month.month,
            dueAt: item.dueDateIn(month),
            status: OccurrenceStatus.due,
          ),
          // Belt and braces against a concurrent write from the background
          // isolate; the unique key is what actually guarantees one per month.
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
    return missing.length;
  }

  /// The plan for [month], recomputed on every write that could change it.
  ///
  /// Materializing here rather than at the call site means opening a month —
  /// or adding an item while looking at one — fills in its occurrences
  /// without the UI having to know that occurrences exist.
  Stream<MonthPlan> watchMonthPlan(JalaliMonth month) {
    return _planChanges().asyncMap((_) async {
      await materialize(month);
      return readMonthPlan(month);
    });
  }

  Future<MonthPlan> readMonthPlan(JalaliMonth month) async {
    final occurrences = await (select(recurringOccurrences)
          ..where((o) =>
              o.jYear.equals(month.year) & o.jMonth.equals(month.month))
          ..orderBy([(o) => OrderingTerm.asc(o.dueAt)]))
        .get();
    final entries = await _joinItems(occurrences);
    final actual = await attachedDatabase.transactionsDao.monthTotals(month);

    return MonthPlan(
      month: month,
      incomes: entries.where((e) => e.item.isIncome).toList(),
      expenses: entries.where((e) => !e.item.isIncome).toList(),
      actualIncomeRial: actual.incomeRial,
      actualExpenseRial: actual.expenseRial,
    );
  }

  /// Attaches each occurrence to its recurring item and category.
  ///
  /// Inactive items are included: turning an item off shouldn't make the
  /// occurrences it already produced vanish from a month the user is reading.
  Future<List<PlannedEntry>> _joinItems(
      List<RecurringOccurrence> occurrences) async {
    if (occurrences.isEmpty) return const [];

    final items = {
      for (final item in await readItems(includeInactive: true))
        (item.kind, item.id): item,
    };
    final categoriesById = {
      for (final category in await select(categories).get())
        category.id: category,
    };

    final entries = <PlannedEntry>[];
    for (final occurrence in occurrences) {
      final item = items[(occurrence.ownerKind, occurrence.ownerId)];
      // A debt's occurrences (owned by the debts screen), or an orphan left
      // by a row deleted outside deleteItem, have no place on the plan.
      if (item == null) continue;
      entries.add(PlannedEntry(
        item: item,
        occurrence: occurrence,
        category: categoriesById[item.categoryId],
      ));
    }
    return entries;
  }

  Future<RecurringOccurrence?> findOccurrence(int id) =>
      (select(recurringOccurrences)..where((o) => o.id.equals(id)))
          .getSingleOrNull();

  /// Settles an occurrence: writes the transaction it stands for and links
  /// the two in one database transaction, so a crash can't leave an
  /// occurrence marked done with no money behind it.
  ///
  /// Returns the id of the transaction that was written.
  /// [accountId] and [categoryId] are [Value]s rather than plain nullables so
  /// the caller can say "no account" and mean it, instead of falling back to
  /// the item's default.
  Future<int> markDone({
    required PlannedEntry entry,
    int? amountRial,
    DateTime? paidAt,
    Value<int?> accountId = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    String? note,
  }) {
    final item = entry.item;
    final amount = amountRial ?? entry.amountRial;
    final when = paidAt ?? DateTime.now();

    return transaction(() async {
      final transactionId = await into(transactions).insert(
        buildTransactionCompanion(
          type: item.txnType,
          amountRial: amount,
          occurredAt: when,
          status: TxnStatus.confirmed,
          source: TxnSource.recurring,
          accountId: accountId.present ? accountId.value : item.accountId,
          categoryId: categoryId.present ? categoryId.value : item.categoryId,
          // The item's title is what the user recognizes in the ledger.
          note: note?.isNotEmpty ?? false ? note : item.title,
          confirmedAt: when,
        ),
      );

      await (update(recurringOccurrences)
            ..where((o) => o.id.equals(entry.occurrence.id)))
          .write(RecurringOccurrencesCompanion(
        status: const Value(OccurrenceStatus.done),
        // Only record an override when this month really differed, so the
        // occurrence keeps following later edits to the item's amount.
        amountOverrideRial:
            Value(amount == item.amountRial ? null : amount),
        transactionId: Value(transactionId),
        resolvedAt: Value(when),
      ));

      return transactionId;
    });
  }

  /// Marks an occurrence as "not this month" without writing a transaction.
  Future<void> skip(int occurrenceId) {
    return (update(recurringOccurrences)
          ..where((o) => o.id.equals(occurrenceId)))
        .write(RecurringOccurrencesCompanion(
      status: const Value(OccurrenceStatus.skipped),
      resolvedAt: Value(DateTime.now()),
    ));
  }

  /// Puts an occurrence back to `due`, deleting the transaction it generated.
  /// That transaction only ever existed because of this occurrence, so
  /// leaving it behind would double-count the month.
  Future<void> reopen(int occurrenceId) {
    return transaction(() async {
      final occurrence = await findOccurrence(occurrenceId);
      if (occurrence == null) return;

      final transactionId = occurrence.transactionId;
      if (transactionId != null) {
        await (delete(transactions)..where((t) => t.id.equals(transactionId)))
            .go();
      }
      await (update(recurringOccurrences)
            ..where((o) => o.id.equals(occurrenceId)))
          .write(const RecurringOccurrencesCompanion(
        status: Value(OccurrenceStatus.due),
        amountOverrideRial: Value(null),
        transactionId: Value(null),
        resolvedAt: Value(null),
      ));
    });
  }

  /// Overrides just this month's amount, leaving the item's default alone.
  Future<void> overrideAmount(int occurrenceId, int? amountRial) {
    return (update(recurringOccurrences)
          ..where((o) => o.id.equals(occurrenceId)))
        .write(RecurringOccurrencesCompanion(
      amountOverrideRial: Value(amountRial),
    ));
  }

  /// Unsettled occurrences due on or before [until], oldest first — what the
  /// reminder scheduler and the overdue badge read.
  ///
  /// Deliberately not scoped to a month: a bill left unpaid since last month
  /// is exactly the one worth surfacing.
  Stream<List<PlannedEntry>> watchOutstanding({DateTime? until}) =>
      _planChanges().asyncMap((_) => readOutstanding(until: until));

  Future<List<PlannedEntry>> readOutstanding({DateTime? until}) async {
    final query = select(recurringOccurrences)
      ..where((o) => o.status.equalsValue(OccurrenceStatus.due))
      ..orderBy([(o) => OrderingTerm.asc(o.dueAt)]);
    if (until != null) {
      query.where((o) => o.dueAt.isSmallerOrEqualValue(until));
    }
    return _joinItems(await query.get());
  }

  /// Realigns unsettled occurrences after the item's day of month changed.
  /// Settled ones keep the date the money actually moved on.
  Future<void> _refreshDueDates(OwnerKind kind, int id, int jDay) async {
    final due = await (select(recurringOccurrences)
          ..where((o) =>
              o.ownerKind.equalsValue(kind) &
              o.ownerId.equals(id) &
              o.status.equalsValue(OccurrenceStatus.due)))
        .get();

    for (final occurrence in due) {
      final month = JalaliMonth(occurrence.jYear, occurrence.jMonth);
      await (update(recurringOccurrences)
            ..where((o) => o.id.equals(occurrence.id)))
          .write(RecurringOccurrencesCompanion(
        dueAt: Value(JalaliUtils.dateForDayOfMonth(month, jDay)),
      ));
    }
  }

  // One companion builder per table, both fed by the same draft. [createdAt]
  // is passed only on insert — an edit must not restamp it.
  RecurringIncomesCompanion _incomeCompanion(RecurringDraft draft,
          {DateTime? createdAt}) =>
      RecurringIncomesCompanion(
        title: Value(draft.title),
        amountRial: Value(draft.amountRial),
        categoryId: Value(draft.categoryId),
        accountId: Value(draft.accountId),
        jDay: Value(draft.jDay),
        startJYear: Value(draft.start.year),
        startJMonth: Value(draft.start.month),
        endJYear: Value(draft.end?.year),
        endJMonth: Value(draft.end?.month),
        note: Value(draft.note),
        isActive: Value(draft.isActive),
        createdAt: Value.absentIfNull(createdAt),
      );

  RecurringExpensesCompanion _expenseCompanion(RecurringDraft draft,
          {DateTime? createdAt}) =>
      RecurringExpensesCompanion(
        title: Value(draft.title),
        amountRial: Value(draft.amountRial),
        categoryId: Value(draft.categoryId),
        accountId: Value(draft.accountId),
        jDay: Value(draft.jDay),
        startJYear: Value(draft.start.year),
        startJMonth: Value(draft.start.month),
        endJYear: Value(draft.end?.year),
        endJMonth: Value(draft.end?.month),
        note: Value(draft.note),
        isActive: Value(draft.isActive),
        createdAt: Value.absentIfNull(createdAt),
      );

  /// Emits once immediately and again on every write to a table the plan is
  /// derived from. Cheaper than a hand-rolled combineLatest over four
  /// separate watches, and drift's change tracking does the diffing.
  Stream<void> _planChanges() => customSelect(
        'SELECT 1',
        readsFrom: {
          recurringIncomes,
          recurringExpenses,
          recurringOccurrences,
          transactions,
          categories,
        },
      ).watch();
}
