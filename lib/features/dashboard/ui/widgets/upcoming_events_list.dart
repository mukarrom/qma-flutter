import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({super.key});

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
            Text('Upcoming Events',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Upcoming Event ${index + 1}'),
                  subtitle: Text('Description of Upcoming Event ${index + 1}'),
                  trailing: Text(DateFormat('MMM d, HH:mm')
                      .format(DateTime.now().add(Duration(days: index + 7)))),
                  onTap: () {
                    // TODO: Show upcoming event details
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