import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/ui/controllers/category_controller.dart';
import 'package:qma/features/library/ui/controllers/category_delete_forever_controller.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/category_update_controller.dart';
import 'package:qma/features/library/ui/controllers/deleted_category_list_controller.dart';

class DeletedCategoryScreen extends StatefulWidget {
  const DeletedCategoryScreen({super.key});

  @override
  State<DeletedCategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<DeletedCategoryScreen> {
  final DeletedCategoryListController _controller =
      Get.find<DeletedCategoryListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Deleted Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<DeletedCategoryListController>(builder: (controller) {
        return ListView.separated(
          itemCount: controller.deletedCategoryList!.length,
          itemBuilder: (context, index) {
            return Material(
              elevation: 4,
              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.category_outlined),
                title: Row(
                  children: [
                    Text(
                        controller.deletedCategoryList?[index].name ??
                            "Category Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor,
                        )),
                  ],
                ),
                subtitle: Text(
                    "Total associated products: ${controller.deletedCategoryList![index].totalProducts}"),
                trailing: Wrap(
                  children: [
                    GetBuilder<CategoryController>(builder: (controller) {
                      if (controller.isLoading) {
                        return CircularProgressIndicator();
                      }
                      return IconButton(
                        onPressed: () => _onClickRestoreButton(index),
                        icon: Icon(
                          Icons.restore_outlined,
                          color: Colors.blue,
                        ),
                      );
                    }),
                    IconButton(
                      onPressed: () => _onClickDeleteButton(index),
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
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
    );
  }

  Future<void> _onClickDeleteButton(int index) async {
    bool isSuccess = await Get.find<CategoryDeleteForeverController>()
        .deleteCategoryForeverById(
            categoryId:
                _controller.deletedCategoryList?[index].sId.toString() ?? "");
    if (isSuccess) {
      _controller.deletedCategoryList!.removeAt(index);
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context, "Category deleted successfully");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            Get.find<CategoryDeleteForeverController>().errorMessage, true);
      }
    }
  }

  Future<void> _onClickRestoreButton(int index) async {
    bool isSuccess =
        await Get.find<CategoryUpdateController>().updateCategoryById(
      categoryId: _controller.deletedCategoryList?[index].sId.toString() ?? "",
      body: {"isDeleted": false},
    );
    if (isSuccess) {
      _controller.deletedCategoryList!.removeAt(index);
      Get.find<CategoryListController>().getAllCategories();
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context, "Category restored successfully");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Failed to restore category", true);
      }
    }
  }
}
