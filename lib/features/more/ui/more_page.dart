import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// "More" tab: categories, wishes, and settings. Wishes land in Phase 5,
/// settings incrementally.
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بیشتر')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('دسته‌بندی‌ها'),
            subtitle: const Text('افزودن، ویرایش و حذف'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/more/categories'),
          ),
          const ListTile(
            leading: Icon(Icons.star_border),
            title: Text('آرزوها'),
            subtitle: Text('به‌زودی'),
            enabled: false,
          ),
          const ListTile(
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
