import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnpaidFeesList extends StatelessWidget {
  const UnpaidFeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Students with Unpaid Fees',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Student ${index + 1}'),
                  subtitle: Text('Class ${index + 6}'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${(index + 1) * 100}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          'Due: ${DateFormat('MMM d').format(DateTime.now().add(Duration(days: index + 1)))}',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                  onTap: () {
                    // TODO: Navigate to student details
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
