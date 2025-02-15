import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/ui/controllers/category_controller.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/category_move_to_delete_list_controller.dart';
import 'package:qma/features/library/ui/controllers/deleted_category_list_controller.dart';
import 'package:qma/features/library/ui/widgets/update_or_create_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryListController _categoryController =
      Get.find<CategoryListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          onPressed: () => onClickUpdateOrCreateCategory(context, setState),
          icon: Icon(Icons.add),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          tooltip: "Create a new category",
        ),
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTapDown: (details) {
          setState(() {});
        },
        child: GetBuilder<CategoryListController>(builder: (controller) {
          return ListView.separated(
            itemCount: controller.categoryList!.length,
            itemBuilder: (context, index) {
              return Material(
                elevation: 8,
                child: ListTile(
                  // onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) {
                  //     return ProductDetailsScreen(
                  //       index: index,
                  //     );
                  //   }));
                  // },
                  leading: const Icon(Icons.category_outlined),
                  title: Row(
                    children: [
                      Text(controller.categoryList?[index].name ??
                          "Category Name"),
                    ],
                  ),
                  subtitle: Text(
                      "Products: ${controller.categoryList?[index].totalProducts}"),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () => onClickUpdateOrCreateCategory(
                          context,
                          setState,
                          index: index,
                        ),
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                          onPressed: () => _onClickDeleteButton(index),
                          icon: GetBuilder<CategoryController>(builder: (ctr) {
                            if (ctr.isLoading) {
                              return CircularProgressIndicator();
                            }
                            return Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            );
                          })),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
        }),
      ),
    );
  }

  Future<void> _onClickDeleteButton(int index) async {
    bool isSuccess = await Get.find<CategoryMoveToDeleteListController>()
        .moveToDeletedScreenById(
            categoryId:
                _categoryController.categoryList?[index].sId.toString() ?? "");
    if (isSuccess) {
      _categoryController.categoryList!.removeAt(index);
      Get.find<DeletedCategoryListController>().getDeletedCategories();
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context, "Category deleted successfully");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Failed to delete category", true);
      }
    }
  }
}
