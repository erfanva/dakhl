import 'package:flutter/material.dart';

import '../../../shared/ui/coming_soon_view.dart';

/// Placeholder for the debts & credits tab. Built out in Phase 4.
class PlaceholderDebtsPage extends StatelessWidget {
  const PlaceholderDebtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بدهی و طلب')),
      body: const ComingSoonView(
        icon: Icons.handshake_outlined,
        message: 'مدیریت بدهی‌ها و طلب‌ها به‌زودی اینجا اضافه می‌شود.',
      ),
    );
  }
}
