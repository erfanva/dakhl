import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/db/providers.dart';
import 'router.dart';
import 'theme.dart';

class DakhlApp extends ConsumerWidget {
  const DakhlApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watched here, and nowhere else, so reminder scheduling follows the
    // database for as long as the app is alive.
    ref.watch(reminderSyncProvider);

    return MaterialApp.router(
      title: 'دخل',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      locale: const Locale('fa'),
      supportedLocales: const [Locale('fa')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
