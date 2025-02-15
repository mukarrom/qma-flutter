import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinanceChart extends StatelessWidget {
  const FinanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Income vs Expenses (Last 12 Months)',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100000,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // tooltipBgColor: Colors.blueAccent,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String type = rodIndex == 0 ? 'Income' : 'Expenses';
                        return BarTooltipItem(
                          '$type: \$${rod.fromY.toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Jan');
                            case 2:
                              return const Text('Feb');
                            case 4:
                              return const Text('Mar');
                            case 6:
                              return const Text('Apr');
                            case 8:
                              return const Text('May');
                            case 10:
                              return const Text('Jun');
                            case 12:
                              return const Text('Jul');
                            case 14:
                              return const Text('Aug');
                            case 16:
                              return const Text('Sep');
                            case 18:
                              return const Text('Oct');
                            case 20:
                              return const Text('Nov');
                            case 22:
                              return const Text('Dec');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 20000 == 0) {
                            return Text('\$${value ~/ 1000}k');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                      12, (index) => _generateMonthlyBarGroup(index)),
                  groupsSpace: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateMonthlyBarGroup(int x) {
    double income = 50000 + (Random().nextDouble() * 30000);
    double expenses = 40000 + (Random().nextDouble() * 20000);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
            fromY: income, color: Colors.green, width: 16, toY: 100000),
        BarChartRodData(
            fromY: expenses, color: Colors.red, width: 16, toY: 100000),
      ],
    );
  }
}