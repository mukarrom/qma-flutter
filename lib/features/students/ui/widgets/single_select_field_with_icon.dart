import 'package:flutter/material.dart';
import 'package:qma/features/common/ui/widgets/qms_select_widget.dart';

class SingleSelectFieldWithIcon extends StatelessWidget {
  const SingleSelectFieldWithIcon({
    super.key,
    this.hint,
    this.label,
    this.keyboardType,
    this.validator,
    this.controller,
    this.icon,
    this.dropdownItems,
    this.width,
    this.required = false,
  });

  final double? width;
  final List<String>? dropdownItems;
  final IconData? icon;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? required;

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
              child: SelectWidget(
                dropdownItems: dropdownItems,
                labelText: label ?? hint ?? "",
                required: required,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
