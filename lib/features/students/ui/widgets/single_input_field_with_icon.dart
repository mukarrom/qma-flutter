import 'package:flutter/material.dart';

class SingleInputFieldWithIcon extends StatelessWidget {
  const SingleInputFieldWithIcon({
    super.key,
    this.hint,
    this.label,
    this.keyboardType,
    this.validator,
    this.controller,
    this.icon,
    this.width,
    this.required = false,
  });

  final double? width;
  final IconData? icon;
  final bool? required;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 16,
        children: [
          Icon(
            icon ?? Icons.person_outline,
            color: icon != null ? null : Colors.transparent,
          ),
          Expanded(
            child: LimitedBox(
              maxWidth: 250,
              child: TextFormField(
                style: TextStyle(
                  fontFamily: 'Ador',
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  label: RichText(
                    text: TextSpan(
                      text: label ?? hint ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Ador',
                      ),
                      children: [
                        if (required == true)
                          TextSpan(
                            text: " *",
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                ),
                keyboardType: keyboardType ?? TextInputType.name,
                validator: validator,
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
