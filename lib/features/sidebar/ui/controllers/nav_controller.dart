import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/features/sidebar/data/data/nav_item_data.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';

class NavController extends GetxController {
  String _selectedNavItemPath = 'dashboard';

  String get selectedNavItemPath => _selectedNavItemPath;

  /// returns a map like: { dashboard: Dashboard(), users: Users(), ... }
  Map<String, Widget> buildNavItemWidget() {
    final Map<String, Widget> navItems = {};
    for (NavItemModel element in NavItemData.navList) {
      if (element.path != null) {
        navItems[element.path!] = element.screen!;
      } else {
        for (var child in element.children) {
          navItems[child.path!] = child.screen!;
        }
      }
      update();
    }
    return navItems;
  }

  void onNavItemTapped(String path) {
    _selectedNavItemPath = path;
    update();
  }
}
