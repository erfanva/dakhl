import 'package:drift/drift.dart';

import '../database.dart';

part 'sms_patterns_dao.g.dart';

@DriftAccessor(tables: [SmsPatterns, RawSms])
class SmsPatternsDao extends DatabaseAccessor<AppDatabase>
    with _$SmsPatternsDaoMixin {
  SmsPatternsDao(super.db);

  /// All patterns in the order the parser applies them.
  Stream<List<SmsPattern>> watchPatterns() {
    return (select(smsPatterns)
          ..orderBy([
            (p) => OrderingTerm.asc(p.priority),
            (p) => OrderingTerm.asc(p.bankName),
          ]))
        .watch();
  }

  Future<int> insertPattern(SmsPatternsCompanion entry) =>
      into(smsPatterns).insert(entry);

  Future<bool> updatePattern(SmsPattern entry) =>
      update(smsPatterns).replace(entry);

  Future<void> setEnabled(int id, bool isEnabled) {
    return (update(smsPatterns)..where((p) => p.id.equals(id)))
        .write(SmsPatternsCompanion(isEnabled: Value(isEnabled)));
  }

  /// Built-in patterns are re-seeded on every open, so deleting one would
  /// just bring it back; only user-authored patterns can be removed.
  Future<int> deletePattern(int id) =>
      (delete(smsPatterns)..where((p) => p.id.equals(id) & p.isBuiltIn.equals(false)))
          .go();

  /// Recently received messages, newest first — for debugging why a bank
  /// isn't being recognized.
  Stream<List<RawSm>> watchRecentSms({int limit = 50}) {
    return (select(rawSms)
          ..orderBy([(s) => OrderingTerm.desc(s.receivedAt)])
          ..limit(limit))
        .watch();
  }
}
