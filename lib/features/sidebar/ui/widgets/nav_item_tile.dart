import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/sidebar/ui/controllers/nav_controller.dart';

class NavItemTile extends StatelessWidget {
  NavItemTile({
    super.key,
    required this.path,
    required this.itemName,
    required this.icon,
  });

  /// receives widget from SidebarNav widget
  final String path;
  final String itemName;
  final IconData icon;

  final NavController _controller = Get.find<NavController>();

  /// if path == widget.path, return color
  Color? navColor(String path, Color? color) {
    if (path == _controller.selectedNavItemPath) {
      return color;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(builder: (controller) {
      return ListTile(
        tileColor: navColor(path, AppColors.themeColor),
        leading: Icon(icon, color: navColor(path, Colors.white)),
        title: Text(
          itemName,
          style: TextStyle(
            /// color: call navColor function,
            color: navColor(path, Colors.white),
          ),
        ),

        /// widget receives onItemTapped function from SidebarNav widget
        /// path is passed from SidebarNav widget received from NavItemTile above
        onTap: () => controller.onNavItemTapped(path),
      );
    });
  }
}
