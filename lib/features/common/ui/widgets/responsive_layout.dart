import 'package:flutter/material.dart';
import 'package:qma/app/app_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > AppConstants.tabletMaxWidth) {
        return desktop;
      } else if (constraints.maxWidth > AppConstants.mobileMaxWidth) {
        return tablet ?? mobile;
      } else {
        return mobile;
      }
    });
  }
}
