import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/accounts/ui/accounts_page.dart';
import '../features/budgets/ui/placeholder_month_plan_page.dart';
import '../features/categories/ui/categories_page.dart';
import '../features/categories/ui/category_detail_page.dart';
import '../features/debug/ui/sms_injector_page.dart';
import '../features/debts/ui/placeholder_debts_page.dart';
import '../features/more/ui/more_page.dart';
import '../features/pending/ui/categorize_sheet.dart';
import '../features/pending/ui/pending_inbox_page.dart';
import '../features/settings/ui/settings_page.dart';
import '../features/settings/ui/sms_patterns_page.dart';
import '../features/setup/ui/setup_page.dart';
import '../features/reports/ui/reports_page.dart';
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
    // Above the shell so a notification tap can open it over any tab, and
    // on cold start before a tab is even chosen.
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/categorize/:id',
      pageBuilder: (context, state) => _categorizeSheetPage(state),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/setup',
      builder: (context, state) => const SetupPage(),
    ),
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
              routes: [
                GoRoute(
                  path: 'accounts',
                  builder: (context, state) => const AccountsPage(),
                ),
                GoRoute(
                  path: 'pending',
                  builder: (context, state) => const PendingInboxPage(),
                ),
              ],
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
              builder: (context, state) => const ReportsPage(),
              routes: [
                GoRoute(
                  path: 'category/:id',
                  builder: (context, state) => CategoryDetailPage(
                    categoryId: int.parse(state.pathParameters['id']!),
                  ),
                ),
              ],
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
                  path: 'settings',
                  builder: (context, state) => const SettingsPage(),
                  routes: [
                    GoRoute(
                      path: 'sms-patterns',
                      builder: (context, state) => const SmsPatternsPage(),
                    ),
                    GoRoute(
                      path: 'sms-injector',
                      builder: (context, state) => const SmsInjectorPage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'categories',
                  builder: (context, state) => const CategoriesPage(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) => CategoryDetailPage(
                        categoryId: int.parse(state.pathParameters['id']!),
                      ),
                    ),
                  ],
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

/// The categorize sheet rendered as a modal route, so notification deep
/// links land on a real navigator entry that can be popped normally.
Page<void> _categorizeSheetPage(GoRouterState state) {
  final id = int.tryParse(state.pathParameters['id'] ?? '');
  return ModalBottomSheetPage(
    child: id == null
        ? const SizedBox.shrink()
        : CategorizeSheet(transactionId: id),
  );
}

/// Minimal Page wrapper that shows its child in a modal bottom sheet.
class ModalBottomSheetPage extends Page<void> {
  const ModalBottomSheetPage({required this.child, super.key});

  final Widget child;

  @override
  Route<void> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<void>(
      settings: this,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => child,
    );
  }
}
