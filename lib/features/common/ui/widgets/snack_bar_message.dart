import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: isErrorMessage ? Colors.red : Colors.green,
    ),
  );
}
