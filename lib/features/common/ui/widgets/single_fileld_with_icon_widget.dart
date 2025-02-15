import 'package:flutter/material.dart';

class SingleFieldWithIconWidget extends StatelessWidget {
  const SingleFieldWithIconWidget({
    super.key,
    required this.child,
    this.icon,
    this.width,
  });

  final Widget child;
  final double? width;
  final IconData? icon;

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
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
