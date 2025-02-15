import 'package:flutter/material.dart';

class PlusMinusButton extends StatelessWidget {
  const PlusMinusButton(
      {super.key, this.onTap, required this.buttonText, this.buttonColor});

  final VoidCallback? onTap;
  final String buttonText;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: buttonColor ?? Colors.red,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
