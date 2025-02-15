import 'package:flutter/material.dart';
import 'package:qma/features/dashboard/ui/screens/dashboard_screen.dart';
import 'package:qma/features/sidebar/data/data/library_nav_items.dart';
import 'package:qma/features/sidebar/data/data/students_nav_items.dart';
import 'package:qma/features/sidebar/data/data/users_nav_items.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';

class NavItemData {
  static final List<NavItemModel> navList = [
    NavItemModel(
      name: "ড্যাশবোর্ড",
      icon: Icons.dashboard,
      path: "dashboard",
      screen: const DashboardScreen(),
    ),
    NavItemModel(
      name: "ইউজার",
      icon: Icons.supervised_user_circle_sharp,
      path: null,
      children: UsersNavItems.items,
    ),
    NavItemModel(
      name: "শিক্ষার্থী",
      icon: Icons.school,
      path: null,
      children: StudentsNavItems.items,
    ),
    // NavItemModel(
    //   name: "শিক্ষক/স্টাফ",
    //   icon: Icons.person,
    //   path: null,
    //   children: [],
    // ),
    NavItemModel(
      name: "তালিমাত",
      icon: Icons.business_sharp,
      path: null,
      children: [],
    ),
    // NavItemModel(
    //   name: "প্রতিষ্ঠান",
    //   icon: Icons.work,
    //   path: null,
    //   children: [],
    // ),
    // NavItemModel(
    //   name: "কর্মচারী",
    //   icon: Icons.work,
    //   path: null,
    //   children: [],
    // ),
    NavItemModel(
      name: "লাইব্রেরী",
      icon: Icons.local_library_outlined,
      path: null,
      children: LibraryNavItems.items,
    ),
  ];
}
