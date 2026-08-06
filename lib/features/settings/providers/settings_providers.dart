import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/database.dart';
import '../../../core/db/providers.dart';

final smsPatternsProvider =
    StreamProvider.autoDispose<List<SmsPattern>>((ref) {
  return ref.watch(appDatabaseProvider).smsPatternsDao.watchPatterns();
});

/// Recently received bank-like SMS, for diagnosing an unrecognized bank.
final recentSmsProvider = StreamProvider.autoDispose<List<RawSm>>((ref) {
  return ref.watch(appDatabaseProvider).smsPatternsDao.watchRecentSms();
});
