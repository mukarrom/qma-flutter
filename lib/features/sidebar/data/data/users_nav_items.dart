import 'package:flutter/material.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';
import 'package:qma/features/users/ui/screen/users.dart';

class UsersNavItems {
  static final List<NavItemModel> items = [
    NavItemModel(
      name: "সকল ইউজার",
      icon: Icons.list,
      path: "/user-list",
      screen: const Users(),
    ),
  ];
}
