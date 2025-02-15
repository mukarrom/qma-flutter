import 'package:flutter/material.dart';

class SingleDropDownButtonWithIcon extends StatelessWidget {
  const SingleDropDownButtonWithIcon({
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
    this.onSelected,
  });

  final double? width;
  final List<DropdownMenuEntry<dynamic>>? dropdownItems;
  final IconData? icon;
  final String? hint;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? required;
  final void Function(Object?)? onSelected;
  // final DropdownMenuEntry? initialValue;

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
              child: DropdownMenu(
                label: Wrap(
                  children: [
                    Text("Category"),
                    if (required!)
                      Text(
                        " *",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                initialSelection: "initialSelection",
                onSelected: (value) => onSelected!(value),
                controller: controller,
                width: width ?? 250,
                dropdownMenuEntries: dropdownItems ?? [],
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
