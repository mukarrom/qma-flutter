import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/responsive_layout.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/deleted_category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';
import 'package:qma/features/sidebar/ui/controllers/nav_controller.dart';
import 'package:qma/features/sidebar/ui/screens/main_sidebar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    Get.find<CategoryListController>().getCategories();
    Get.find<DeletedCategoryListController>().getDeletedCategories();
    Get.find<ProductListController>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavController>(builder: (controller) {
      return ResponsiveLayout(
        mobile: _buildMobileAndTabletLayout(controller),
        tablet: _buildMobileAndTabletLayout(controller),
        desktop: _buildDesktopLayout(controller),
      );
    });
  }

  Widget _buildMobileAndTabletLayout(NavController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "qma",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      drawer: const MainSidebar(),
      body: controller.buildNavItemWidget()[controller.selectedNavItemPath]!,
    );
  }

  Widget _buildDesktopLayout(NavController controller) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "qma",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Row(
        children: [
          const MainSidebar(),
          Expanded(
            // display the selected screen from navItemWidget
            child: controller
                .buildNavItemWidget()[controller.selectedNavItemPath]!,
          ),
        ],
      ),
    );
  }
}
