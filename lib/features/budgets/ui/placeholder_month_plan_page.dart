import 'package:flutter/material.dart';

import '../../../shared/ui/coming_soon_view.dart';

/// Placeholder for the month-plan tab (recurring incomes/expenses,
/// budgets). Built out in Phase 4/5.
class PlaceholderMonthPlanPage extends StatelessWidget {
  const PlaceholderMonthPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('برنامه ماه')),
      body: const ComingSoonView(
        icon: Icons.event_note_outlined,
        message: 'درآمد ماهانه، هزینه‌های ثابت و بودجه‌بندی به‌زودی اینجا اضافه می‌شود.',
      ),
    );
  }
}
