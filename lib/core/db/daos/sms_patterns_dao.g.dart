// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_patterns_dao.dart';

// ignore_for_file: type=lint
mixin _$SmsPatternsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SmsPatternsTable get smsPatterns => attachedDatabase.smsPatterns;
  $RawSmsTable get rawSms => attachedDatabase.rawSms;
  SmsPatternsDaoManager get managers => SmsPatternsDaoManager(this);
}

class SmsPatternsDaoManager {
  final _$SmsPatternsDaoMixin _db;
  SmsPatternsDaoManager(this._db);
  $$SmsPatternsTableTableManager get smsPatterns =>
      $$SmsPatternsTableTableManager(_db.attachedDatabase, _db.smsPatterns);
  $$RawSmsTableTableManager get rawSms =>
      $$RawSmsTableTableManager(_db.attachedDatabase, _db.rawSms);
}
