import 'package:drift/drift.dart';

/// Direction of money movement.
enum TxnType { withdrawal, deposit }

/// Lifecycle of a transaction row. Pending is a *status*, not a separate
/// table, so one query feeds both the SMS inbox and the ledger.
enum TxnStatus { pending, confirmed, dismissed }

/// Where the transaction came from.
enum TxnSource { manual, sms, recurring, debtPayment, adjustment }

/// Which kind of transaction a category may be assigned to.
enum CategoryKind { expense, income, both }

/// Outcome of running an SMS through the parser.
enum SmsParseStatus { parsed, unparsedBankLike, ignored }

/// Owner of a recurring occurrence or a reminder rule.
enum OwnerKind { recurringExpense, recurringIncome, debt }

/// State of a single month's instance of a recurring item.
enum OccurrenceStatus { due, done, skipped }

/// Who owes whom.
enum DebtDirection { iOwe, owedToMe }

enum DebtStatus { open, settled }

/// Unit a bank states amounts in, so the parser can convert to Rial.
enum SmsAmountUnit { rial, toman }

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  TextColumn get bankName => text().withLength(max: 60).nullable()();

  /// Trailing digits of the card/account as they appear in bank SMS —
  /// used to route an incoming message to the right account.
  TextColumn get accountNoSuffix => text().withLength(max: 12).nullable()();

  IntColumn get initialBalanceRial => integer().withDefault(const Constant(0))();

  /// Balance as last reported by a bank SMS, used only to detect drift
  /// between recorded transactions and reality.
  IntColumn get lastSmsBalanceRial => integer().nullable()();
  DateTimeColumn get lastSmsBalanceAt => dateTime().nullable()();

  IntColumn get colorValue => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  IntColumn get kind => intEnum<CategoryKind>()();
  IntColumn get iconCode => integer().nullable()();
  IntColumn get colorValue => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// System categories are seeded, undeletable, and excluded from the
  /// "properly categorized" share of the commitment score.
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();

  /// Stable key for looking up seeded system rows (e.g. `debt_payment`).
  TextColumn get systemKey => text().withLength(max: 40).nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId =>
      integer().nullable().references(Accounts, #id, onDelete: KeyAction.setNull)();
  IntColumn get categoryId => integer()
      .nullable()
      .references(Categories, #id, onDelete: KeyAction.setNull)();
  IntColumn get type => intEnum<TxnType>()();
  IntColumn get amountRial => integer()();
  DateTimeColumn get occurredAt => dateTime()();

  /// Denormalized Jalali year/month of [occurredAt] so monthly grouping
  /// is a plain indexed GROUP BY instead of a per-row conversion.
  IntColumn get jYear => integer()();
  IntColumn get jMonth => integer()();

  TextColumn get note => text().nullable()();
  IntColumn get status => intEnum<TxnStatus>()();
  IntColumn get source => intEnum<TxnSource>()();
  IntColumn get rawSmsId =>
      integer().nullable().references(RawSms, #id, onDelete: KeyAction.setNull)();

  /// Balance the bank reported right after this transaction.
  IntColumn get balanceAfterRial => integer().nullable()();
  DateTimeColumn get confirmedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class RawSms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sender => text()();
  TextColumn get body => text()();
  DateTimeColumn get receivedAt => dateTime()();
  IntColumn get parseStatus => intEnum<SmsParseStatus>()();
  IntColumn get matchedPatternId => integer().nullable()();
}

/// A bank's SMS format, stored as data so a new bank can be added from
/// the settings screen without a code change.
class SmsPatterns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bankName => text().withLength(min: 1, max: 60)();

  /// JSON array of sender ids/numbers this bank sends from.
  TextColumn get senderNumbers => text()();

  /// JSON arrays of keywords that mark the transaction direction.
  TextColumn get depositKeywords => text()();
  TextColumn get withdrawalKeywords => text()();

  TextColumn get amountRegex => text()();
  TextColumn get balanceRegex => text().nullable()();
  TextColumn get accountRefRegex => text().nullable()();
  IntColumn get amountUnit => intEnum<SmsAmountUnit>()();

  IntColumn get priority => integer().withDefault(const Constant(100))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
}

/// Columns shared by recurring incomes and recurring expenses.
mixin RecurringColumns on Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 80)();
  IntColumn get amountRial => integer()();
  IntColumn get categoryId => integer()
      .nullable()
      .references(Categories, #id, onDelete: KeyAction.setNull)();
  IntColumn get accountId =>
      integer().nullable().references(Accounts, #id, onDelete: KeyAction.setNull)();

  /// Day of the Jalali month; clamped per month when generating.
  IntColumn get jDay => integer()();
  IntColumn get startJYear => integer()();
  IntColumn get startJMonth => integer()();
  IntColumn get endJYear => integer().nullable()();
  IntColumn get endJMonth => integer().nullable()();

  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}

class RecurringIncomes extends Table with RecurringColumns {}

class RecurringExpenses extends Table with RecurringColumns {}

/// One month's instance of a recurring income or expense.
class RecurringOccurrences extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerKind => intEnum<OwnerKind>()();
  IntColumn get ownerId => integer()();
  IntColumn get jYear => integer()();
  IntColumn get jMonth => integer()();
  DateTimeColumn get dueAt => dateTime()();
  IntColumn get status => intEnum<OccurrenceStatus>()();

  /// Set when this month's amount differed from the recurring default.
  IntColumn get amountOverrideRial => integer().nullable()();

  /// A resolved occurrence always points at the transaction that settled it.
  IntColumn get transactionId => integer()
      .nullable()
      .references(Transactions, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get resolvedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {ownerKind, ownerId, jYear, jMonth},
      ];
}

/// "Remind me [daysBefore] days before, at [minutesOfDay]." Multiple rows
/// per owner give the user as many reminders as they want.
class ReminderRules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerKind => intEnum<OwnerKind>()();
  IntColumn get ownerId => integer()();
  IntColumn get daysBefore => integer()();
  IntColumn get minutesOfDay => integer().withDefault(const Constant(9 * 60))();
}

/// Bookkeeping so reminder scheduling can be diffed and made idempotent,
/// and rebuilt after a reboot.
class ScheduledNotifications extends Table {
  /// Also the notification id handed to flutter_local_notifications.
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerKind => intEnum<OwnerKind>()();
  IntColumn get ownerId => integer()();
  IntColumn get occurrenceId => integer().nullable()();
  IntColumn get ruleId => integer().nullable()();
  DateTimeColumn get fireAt => dateTime()();
  TextColumn get payload => text()();
}

class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get direction => intEnum<DebtDirection>()();
  TextColumn get personName => text().withLength(min: 1, max: 80)();
  TextColumn get title => text().withLength(max: 100).nullable()();
  IntColumn get totalAmountRial => integer()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  IntColumn get status => intEnum<DebtStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get settledAt => dateTime().nullable()();
}

class DebtPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get debtId =>
      integer().references(Debts, #id, onDelete: KeyAction.cascade)();
  IntColumn get amountRial => integer()();
  DateTimeColumn get paidAt => dateTime()();

  /// Set when the payment was recorded from a real transaction.
  IntColumn get transactionId => integer()
      .nullable()
      .references(Transactions, #id, onDelete: KeyAction.setNull)();
  TextColumn get note => text().nullable()();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get jYear => integer()();
  IntColumn get jMonth => integer()();

  /// Null means an overall cap for the month rather than a per-category one.
  IntColumn get categoryId => integer()
      .nullable()
      .references(Categories, #id, onDelete: KeyAction.cascade)();
  IntColumn get capAmountRial => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {jYear, jMonth, categoryId},
      ];
}

class Wishes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();

  /// Optional target date, stored as an instant like every other date.
  DateTimeColumn get targetAt => dateTime().nullable()();
  IntColumn get estimatedCostRial => integer().nullable()();
  IntColumn get sortOrder => integer()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

class WishLinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wishId =>
      integer().references(Wishes, #id, onDelete: KeyAction.cascade)();
  TextColumn get url => text()();
  TextColumn get label => text().withLength(max: 80).nullable()();
}

class WishImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get wishId =>
      integer().references(Wishes, #id, onDelete: KeyAction.cascade)();

  /// Path relative to the app documents directory.
  TextColumn get relativePath => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
