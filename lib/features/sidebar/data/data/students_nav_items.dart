import 'package:flutter/material.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';
import 'package:qma/features/students/ui/screens/students_screen.dart';

class StudentsNavItems {
  static final List<NavItemModel> items = [
    NavItemModel(
      name: "শিক্ষার্থী তালিকা",
      icon: Icons.list,
      path: "/students-list",
      screen: const StudentsScreen(),
    ),
  ];
}
