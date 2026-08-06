import 'package:flutter/material.dart';

import '../../../shared/ui/coming_soon_view.dart';

/// Placeholder for the reports tab (charts, commitment score). Built out
/// starting Phase 2 (basic charts) and Phase 5 (commitment score).
class PlaceholderReportsPage extends StatelessWidget {
  const PlaceholderReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('گزارش‌ها')),
      body: const ComingSoonView(
        icon: Icons.bar_chart_outlined,
        message: 'نمودار درآمد و هزینه به‌زودی اینجا اضافه می‌شود.',
      ),
    );
  }
}
