import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ClassAttendanceBarChart extends StatelessWidget {
  const ClassAttendanceBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Class Attendance',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // tooltipBgColor: Colors.blueAccent,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String status = rodIndex == 0 ? 'Present' : 'Absent';
                        return BarTooltipItem(
                          // '$status: ${rod.y.toStringAsFixed(1)}%',
                          '$status: ${rod.fromY.toStringAsFixed(1)}%',
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
                                    return const Text('Class 1');
                                  case 1:
                                    return const Text('Class 2');
                                  case 2:
                                    return const Text('Class 3');
                                  case 3:
                                    return const Text('Class 4');
                                  case 4:
                                    return const Text('Class 5');
                                  default:
                                    return const Text('');
                                }
                              })),
                      // bottomTitles: SideTitles(
                      //   showTitles: true,
                      //   getTitles: (double value) {
                      //     return 'Class ${value.toInt() + 1}';
                      //   },
                      // ),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return const Text('');
                              }))
                      // leftTitles: const SideTitles(showTitles: true),
                      ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _generateBarGroup(0, 85, 15),
                    _generateBarGroup(1, 90, 10),
                    _generateBarGroup(2, 88, 12),
                    _generateBarGroup(3, 92, 8),
                    _generateBarGroup(4, 87, 13),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(
      int x, double presentPercentage, double absentPercentage) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: presentPercentage,
          color: Colors.green,
          width: 16,
          toY: 100,
        ),
        BarChartRodData(
          fromY: absentPercentage,
          color: Colors.red,
          width: 16,
          toY: 100,
        ),
      ],
    );
  }
}
