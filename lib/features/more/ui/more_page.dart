import 'package:flutter/material.dart';

/// "More" tab: categories, wishes, and settings. Categories management
/// lands in Phase 2, wishes in Phase 5, settings incrementally.
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بیشتر')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text('دسته‌بندی‌ها'),
            subtitle: Text('به‌زودی'),
            enabled: false,
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('آرزوها'),
            subtitle: Text('به‌زودی'),
            enabled: false,
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('تنظیمات'),
            subtitle: Text('به‌زودی'),
            enabled: false,
          ),
        ],
      ),
    );
  }
}
