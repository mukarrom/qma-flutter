import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GenderPieChart extends StatelessWidget {
  const GenderPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Students by Gender',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 55,
                      title: '55%',
                      radius: 50,
                      titleStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    PieChartSectionData(
                      color: Colors.pink,
                      value: 45,
                      title: '45%',
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
                _LegendItem(color: Colors.blue, label: 'Male: 680 (55%)'),
                _LegendItem(color: Colors.pink, label: 'Female: 554 (45%)'),
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