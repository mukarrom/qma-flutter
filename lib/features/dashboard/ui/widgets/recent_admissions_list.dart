import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentAdmissionsList extends StatelessWidget {
  const RecentAdmissionsList({super.key});

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
            Text('Recent Admissions',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('New Student ${index + 1}'),
                  subtitle: Text('Class ${index + 6}'),
                  trailing: Text(
                      'Admitted: ${DateFormat('MMM d').format(DateTime.now().subtract(Duration(days: index)))}'),
                  leading: CircleAvatar(child: Text('${index + 1}')),
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