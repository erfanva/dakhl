import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/budgets/ui/placeholder_month_plan_page.dart';
import '../features/categories/ui/categories_page.dart';
import '../features/debts/ui/placeholder_debts_page.dart';
import '../features/more/ui/more_page.dart';
import '../features/reports/ui/placeholder_reports_page.dart';
import '../features/transactions/ui/transactions_page.dart';

/// Root navigator key so modal routes (like the future SMS categorize
/// sheet) can be pushed above the bottom-nav shell.
final rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());

/// 5-tab bottom navigation shell, RTL order handled by the widget itself
/// (Directionality from the app locale reverses the visual order).
final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/transactions',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeys[0],
          routes: [
            GoRoute(
              path: '/transactions',
              builder: (context, state) => const TransactionsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeys[1],
          routes: [
            GoRoute(
              path: '/month-plan',
              builder: (context, state) => const PlaceholderMonthPlanPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeys[2],
          routes: [
            GoRoute(
              path: '/debts',
              builder: (context, state) => const PlaceholderDebtsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeys[3],
          routes: [
            GoRoute(
              path: '/reports',
              builder: (context, state) => const PlaceholderReportsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeys[4],
          routes: [
            GoRoute(
              path: '/more',
              builder: (context, state) => const MorePage(),
              routes: [
                GoRoute(
                  path: 'categories',
                  builder: (context, state) => const CategoriesPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'تراکنش‌ها'),
    NavigationDestination(icon: Icon(Icons.event_note_outlined), selectedIcon: Icon(Icons.event_note), label: 'برنامه ماه'),
    NavigationDestination(icon: Icon(Icons.handshake_outlined), selectedIcon: Icon(Icons.handshake), label: 'بدهی/طلب'),
    NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'گزارش‌ها'),
    NavigationDestination(icon: Icon(Icons.more_horiz), selectedIcon: Icon(Icons.more_horiz), label: 'بیشتر'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: _destinations,
      ),
    );
  }
}
