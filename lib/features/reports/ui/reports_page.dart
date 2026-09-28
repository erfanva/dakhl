import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/database.dart';
import '../../../core/money/money.dart';
import '../../../core/persian/digits.dart';
import '../../../core/persian/jalali_utils.dart';
import '../../../shared/ui/month_switcher.dart';
import '../../categories/category_style.dart';
import '../providers/reports_providers.dart';

/// Reports: month summary, income-vs-expense trend, and category breakdown.
/// Follows the month selected on the Transactions tab.
class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('گزارش‌ها')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const MonthSwitcher(),
          const _SummaryCards(),
          const _SectionTitle('روند ۶ ماه اخیر'),
          const _TrendChart(),
          const _SectionTitle('هزینه‌ها به تفکیک دسته'),
          const _CategoryBreakdown(type: TxnType.withdrawal),
          const _SectionTitle('درآمدها به تفکیک دسته'),
          const _CategoryBreakdown(type: TxnType.deposit),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _SummaryCards extends ConsumerWidget {
  const _SummaryCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(monthTotalsProvider).value;
    if (totals == null) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  label: 'درآمد',
                  amountRial: totals.incomeRial,
                  color: Colors.green.shade700,
                  icon: Icons.south_west,
                ),
              ),
              Expanded(
                child: _SummaryCard(
                  label: 'هزینه',
                  amountRial: totals.expenseRial,
                  color: scheme.error,
                  icon: Icons.north_east,
                ),
              ),
            ],
          ),
          _SummaryCard(
            label: totals.netRial >= 0 ? 'مانده ماه' : 'کسری ماه',
            amountRial: totals.netRial,
            color: totals.netRial >= 0 ? scheme.primary : scheme.error,
            icon: totals.netRial >= 0 ? Icons.savings : Icons.warning_amber,
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.amountRial,
    required this.color,
    required this.icon,
  });

  final String label;
  final int amountRial;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Text(label, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 6),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                Money.format(amountRial),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendChart extends ConsumerWidget {
  const _TrendChart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final months = ref.watch(trendTotalsProvider).value;
    if (months == null) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (months.every((m) => m.incomeRial == 0 && m.expenseRial == 0)) {
      return const _EmptyChart('در این بازه تراکنشی ثبت نشده');
    }

    final scheme = Theme.of(context).colorScheme;
    final incomeColor = Colors.green.shade600;
    final expenseColor = scheme.error;
    // Chart in Toman so the axis labels stay readable.
    double toman(int rial) => rial / 10;
    final maxValue = months
        .map((m) => [toman(m.incomeRial), toman(m.expenseRial)].reduce((a, b) => a > b ? a : b))
        .reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxValue * 1.2,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final isIncome = rodIndex == 0;
                      final entry = months[groupIndex];
                      return BarTooltipItem(
                        '${isIncome ? 'درآمد' : 'هزینه'}\n'
                        '${Money.formatCompact(isIncome ? entry.incomeRial : entry.expenseRial)}',
                        TextStyle(
                          color: scheme.onInverseSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= months.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            JalaliUtils.monthNames[months[index].month.month - 1],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  for (var i = 0; i < months.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: toman(months[i].incomeRial),
                          color: incomeColor,
                          width: 9,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        BarChartRodData(
                          toY: toman(months[i].expenseRial),
                          color: expenseColor,
                          width: 9,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: incomeColor, label: 'درآمد'),
              const SizedBox(width: 16),
              _LegendDot(color: expenseColor, label: 'هزینه'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _CategoryBreakdown extends ConsumerWidget {
  const _CategoryBreakdown({required this.type});

  final TxnType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(categoryTotalsProvider(type)).value;
    if (totals == null) {
      return const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (totals.isEmpty) {
      return _EmptyChart(
        type == TxnType.withdrawal
            ? 'این ماه هزینه‌ای ثبت نشده'
            : 'این ماه درآمدی ثبت نشده',
      );
    }

    final grandTotal = totals.fold<int>(0, (sum, t) => sum + t.totalRial);

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 44,
              sections: [
                for (final entry in totals)
                  PieChartSectionData(
                    value: entry.totalRial.toDouble(),
                    color: _sliceColor(entry, context),
                    radius: 40,
                    title: _percentLabel(entry.totalRial, grandTotal),
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (final entry in totals)
          _CategoryRow(entry: entry, grandTotal: grandTotal),
      ],
    );
  }

  Color _sliceColor(CategoryTotal entry, BuildContext context) {
    return entry.category?.color(context) ??
        Theme.of(context).colorScheme.outline;
  }

  String _percentLabel(int part, int total) {
    if (total == 0) return '';
    final percent = (part / total * 100).round();
    // Slivers get no label — it would overflow the slice.
    return percent < 7 ? '' : '${toPersianDigits('$percent')}٪';
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.entry, required this.grandTotal});

  final CategoryTotal entry;
  final int grandTotal;

  @override
  Widget build(BuildContext context) {
    final category = entry.category;
    final color =
        category?.color(context) ?? Theme.of(context).colorScheme.outline;
    final share = grandTotal == 0 ? 0.0 : entry.totalRial / grandTotal;

    return ListTile(
      dense: true,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: color.withValues(alpha: 0.18),
        child: Icon(category?.icon ?? Icons.help_outline,
            size: 16, color: color),
      ),
      title: Text(category?.name ?? 'بدون دسته‌بندی'),
      subtitle: LinearProgressIndicator(
        value: share,
        color: color,
        backgroundColor: color.withValues(alpha: 0.15),
      ),
      trailing: Text(
        Money.format(entry.totalRial),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: category == null
          ? null
          : () => context.go('/reports/category/${category.id}'),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  const _EmptyChart(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
