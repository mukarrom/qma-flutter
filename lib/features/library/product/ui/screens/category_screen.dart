import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/ui/controllers/category_controller.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/widgets/update_or_create_category.dart';
import 'package:qma/services/db/db_helper.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryListController _categoryController =
      Get.find<CategoryListController>();
  final DbHelper dbHelper = DbHelper.instance;

  @override
  void initState() {
    _categoryController.getAllCategories();
    super.initState();
  }

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
            itemCount: controller.categories.length,
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
                  leading:
                      Text((controller.categories[index].id ?? 0).toString()),
                  title: Row(
                    children: [
                      Text(
                          controller.categories[index].name ?? "Category Name"),
                    ],
                  ),
                  subtitle: Text(
                      "Products: ${controller.categories[index].totalProducts}"),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () => onClickUpdateOrCreateCategory(
                          context,
                          setState,
                          index: controller.categories[index].id ?? 0,
                        ),
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                          onPressed: () => _onClickDeleteButton(
                              controller.categories[index].id ?? 0),
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

  Future<void> _onClickDeleteButton(int id) async {
    final db = await dbHelper.database;
    // delete data from sqflite database
    int delete = await db.delete(
      DbHelper.CATEGORY_TABLE_NAME,
      where: '${DbHelper.CATEGORY_COLUMN_ID} = ?',
      whereArgs: [id],
    );

    if (delete > 0) {
      await _categoryController.getAllCategories();
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

  // Future<void> _onClickDeleteButton(int index) async {
  //   bool isSuccess = await Get.find<CategoryMoveToDeleteListController>()
  //       .moveToDeletedScreenById(
  //           categoryId:
  //               _categoryController.categoryList?[index].sId.toString() ?? "");
  //   if (isSuccess) {
  //     _categoryController.categoryList!.removeAt(index);
  //     Get.find<DeletedCategoryListController>().getDeletedCategories();
  //     setState(() {});
  //     if (mounted) {
  //       showSnackBarMessage(context, "Category deleted successfully");
  //     }
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context, "Failed to delete category", true);
  //     }
  //   }
  // }
}
