import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AttendanceLineChart extends StatelessWidget {
  const AttendanceLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Daily Attendance',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.7,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return const Text('Mon');
                                  case 2:
                                    return const Text('Tue');
                                  case 4:
                                    return const Text('Wed');
                                  case 6:
                                    return const Text('Thu');
                                  default:
                                    return const Text('');
                                }
                              }))),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: 7,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 80),
                        const FlSpot(1, 85),
                        const FlSpot(2, 90),
                        const FlSpot(3, 88),
                        const FlSpot(4, 92),
                        const FlSpot(5, 87),
                        const FlSpot(6, 89),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                          show: true, color: Colors.blue.withOpacity(0.1)),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      /// tooltips background color
                      // tooltipBgColor: Colors.blueAccent,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final flSpot = barSpot;

                          return LineTooltipItem(
                            '${flSpot.y.toStringAsFixed(1)}%\n${_getDateForSpot(flSpot.x.toInt())}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDateForSpot(int index) {
    final date = DateTime.now().subtract(Duration(days: 6 - index));
    return DateFormat('MMM d').format(date);
  }
}
