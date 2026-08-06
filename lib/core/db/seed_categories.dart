import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import 'database.dart';

/// Stable keys for the system categories the app reasons about in code.
abstract final class SystemCategoryKeys {
  static const uncategorized = 'uncategorized';
  static const debtPayment = 'debt_payment';
  static const creditReceived = 'credit_received';
  static const balanceAdjustment = 'balance_adjustment';
  static const selfTransfer = 'self_transfer';

  /// Categories that don't count as "the user actually categorized this"
  /// when computing the commitment score.
  static const uncountedForScore = {uncategorized};
}

class _SeedCategory {
  const _SeedCategory(this.name, this.kind, this.icon, this.color,
      {this.systemKey});

  final String name;
  final CategoryKind kind;
  final IconData icon;
  final Color color;
  final String? systemKey;
}

const _systemCategories = <_SeedCategory>[
  _SeedCategory('نامشخص', CategoryKind.both, Icons.help_outline, Colors.grey,
      systemKey: SystemCategoryKeys.uncategorized),
  _SeedCategory('پرداخت بدهی', CategoryKind.expense, Icons.handshake_outlined,
      Colors.deepOrange,
      systemKey: SystemCategoryKeys.debtPayment),
  _SeedCategory('دریافت طلب', CategoryKind.income, Icons.volunteer_activism,
      Colors.teal,
      systemKey: SystemCategoryKeys.creditReceived),
  _SeedCategory('اصلاح موجودی', CategoryKind.both, Icons.tune, Colors.blueGrey,
      systemKey: SystemCategoryKeys.balanceAdjustment),
  _SeedCategory('انتقال بین حساب‌ها', CategoryKind.both, Icons.swap_horiz,
      Colors.indigo,
      systemKey: SystemCategoryKeys.selfTransfer),
];

/// Everyday categories the user starts with; all editable and deletable.
const _defaultCategories = <_SeedCategory>[
  _SeedCategory('خوراک', CategoryKind.expense, Icons.restaurant, Colors.orange),
  _SeedCategory('خواربار', CategoryKind.expense, Icons.local_grocery_store,
      Colors.lightGreen),
  _SeedCategory(
      'حمل‌ونقل', CategoryKind.expense, Icons.directions_bus, Colors.blue),
  _SeedCategory('مسکن و اجاره', CategoryKind.expense, Icons.home, Colors.brown),
  _SeedCategory('قبوض', CategoryKind.expense, Icons.receipt_long, Colors.amber),
  _SeedCategory('سلامت', CategoryKind.expense, Icons.local_hospital, Colors.red),
  _SeedCategory('پوشاک', CategoryKind.expense, Icons.checkroom, Colors.purple),
  _SeedCategory(
      'تفریح', CategoryKind.expense, Icons.sports_esports, Colors.pink),
  _SeedCategory('آموزش', CategoryKind.expense, Icons.school, Colors.cyan),
  _SeedCategory('اینترنت و موبایل', CategoryKind.expense, Icons.wifi,
      Colors.lightBlue),
  _SeedCategory('هدیه', CategoryKind.expense, Icons.card_giftcard, Colors.pinkAccent),
  _SeedCategory('حقوق', CategoryKind.income, Icons.payments, Colors.green),
  _SeedCategory('درآمد آزاد', CategoryKind.income, Icons.work_outline,
      Colors.lightGreen),
  _SeedCategory('سود و سرمایه‌گذاری', CategoryKind.income, Icons.trending_up,
      Colors.teal),
];

/// Inserts system and default categories on database creation.
Future<void> seedSystemCategories(AppDatabase db) async {
  final now = DateTime.now();
  var order = 0;

  Future<void> insert(_SeedCategory seed, {required bool isSystem}) {
    return db.into(db.categories).insert(
          CategoriesCompanion.insert(
            name: seed.name,
            kind: seed.kind,
            iconCode: Value(seed.icon.codePoint),
            colorValue: Value(seed.color.toARGB32()),
            sortOrder: Value(order++),
            isSystem: Value(isSystem),
            systemKey: Value.absentIfNull(seed.systemKey),
            createdAt: now,
          ),
        );
  }

  for (final seed in _defaultCategories) {
    await insert(seed, isSystem: false);
  }
  for (final seed in _systemCategories) {
    await insert(seed, isSystem: true);
  }
}
