import 'package:flutter/material.dart';
import 'package:qma/features/library/ui/screens/category_screen.dart';
import 'package:qma/features/library/ui/screens/deleted_category_screen.dart';
import 'package:qma/features/library/ui/screens/products_screen.dart';
import 'package:qma/features/library/ui/screens/test_sqflite.dart';
import 'package:qma/features/sidebar/data/model/nav_item_model.dart';

class LibraryNavItems {
  static final List<NavItemModel> items = [
    NavItemModel(
      name: "প্রোডাক্টস",
      icon: Icons.library_books_outlined,
      path: "/library/products",
      screen: const ProductsScreen(),
    ),
    NavItemModel(
      name: "Category",
      icon: Icons.category,
      path: "/library/category",
      screen: const CategoryScreen(),
    ),
    NavItemModel(
      name: "Deleted Category",
      icon: Icons.delete_sweep_outlined,
      path: "/library/deleted_category",
      screen: const DeletedCategoryScreen(),
    ),
    NavItemModel(
      name: "Test Sqflite",
      icon: Icons.library_books_outlined,
      path: "/library/test_sqflite",
      screen: TestSqflite(),
    ),
  ];
}
