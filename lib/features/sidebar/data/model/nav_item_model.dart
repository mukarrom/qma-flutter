import 'package:flutter/material.dart';

class NavItemModel {
  final String name;
  final IconData icon;
  final String? path;
  final Widget? screen;
  final List<NavItemModel> children;

  NavItemModel({
    required this.name,
    required this.icon,
    this.children = const [],
    this.path,
    this.screen,
  });
}
