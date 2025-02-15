import 'package:flutter/material.dart';

class FormInputWidget extends StatelessWidget {
  const FormInputWidget({
    super.key,
    this.hint,
    this.label,
    this.keyboardType,
    this.validator,
    this.controller,
  });

  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 250,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          label: Text(label ?? hint ?? ""),
        ),
        keyboardType: keyboardType ?? TextInputType.name,
        validator: validator,
        controller: controller,
      ),
    );
  }
}
