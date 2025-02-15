import 'package:flutter/material.dart';
import 'package:qma/app/app_colors.dart';

class ChangeAlertDialog extends StatelessWidget {
  const ChangeAlertDialog({
    super.key,
    required this.onClickYes,
    this.title = 'You are about to change',
    this.message = 'are you sure?',
  });

  final String? title;
  final String? message;
  final void Function()? onClickYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title!)),
      titleTextStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.themeColor,
        fontFamily: 'Ador',
      ),
      content: Text(
        message!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('না', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: onClickYes,
          child: const Text('হ্যাঁ'),
        ),
      ],
    );
  }
}
