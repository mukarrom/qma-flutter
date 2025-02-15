import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PresentAbsentPieChart extends StatelessWidget {
  const PresentAbsentPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Today\'s Attendance',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: 90,
                      title: '90%',
                      radius: 50,
                      titleStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    PieChartSectionData(
                      color: Colors.red,
                      value: 10,
                      title: '10%',
                      radius: 50,
                      titleStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _LegendItem(color: Colors.green, label: 'Present: 1110 (90%)'),
                _LegendItem(color: Colors.red, label: 'Absent: 124 (10%)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}