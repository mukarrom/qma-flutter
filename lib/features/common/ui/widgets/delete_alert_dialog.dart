import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
    this.title = 'item',
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
            '$title ডিলিট করুন',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          )),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'আপনি কি নিশ্চিত?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Yes', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}