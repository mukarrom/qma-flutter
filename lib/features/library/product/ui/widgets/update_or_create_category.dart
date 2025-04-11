import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/product/data/models/category_model.dart';
import 'package:qma/features/library/product/ui/controllers/category_create_controller.dart';
import 'package:qma/features/library/product/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/product/ui/controllers/category_update_controller.dart';
import 'package:qma/features/library/product/ui/controllers/product_list_controller.dart';
import 'package:qma/features/students/ui/widgets/single_input_field_with_icon.dart';

void onClickUpdateOrCreateCategory(BuildContext context, StateSetter setState,
    {int? index}) {
  final CategoryListController categoryListController =
      Get.find<CategoryListController>();
  final CategoryCreateController categoryCreateController =
      Get.find<CategoryCreateController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameTEC = TextEditingController();
  CategoryModel? category =
      index != null ? categoryListController.categoryList![index] : null;

  if (category != null) {
    categoryNameTEC.text = category.name!;
  }

  Future<void> onClickSave() async {
    if (formKey.currentState!.validate()) {
      bool isCreated = await categoryCreateController.addCategory(
        body: {"name": categoryNameTEC.text},
      );
      if (isCreated) {
        Get.find<CategoryListController>().getAllCategories();
        setState(() {});
        Navigator.pop(context);
      } else {
        showSnackBarMessage(context, "Something went wrong", true);
      }
      // categoryListController.categoryList!.add(
      //   CategoryModel(
      //     name: categoryNameTEC.text,
      //     totalProducts: 0,
      //   ),
      // );
    }
  }

  void onClickUpdate() async {
    if (formKey.currentState!.validate()) {
      bool isSuccess = await Get.find<CategoryUpdateController>()
          .updateCategoryById(
              categoryId: categoryListController.categoryList![index!].sId!,
              body: {"name": categoryNameTEC.text});
      if (isSuccess) {
        // change category name in category list
        categoryListController.categoryList![index].name = categoryNameTEC.text;

        // change category name in product list
        Get.find<ProductListController>().productList?.forEach((product) {
          if (product.category!.sId ==
              categoryListController.categoryList![index].sId) {
            product.category!.name = categoryNameTEC.text;
          }
        });
        showSnackBarMessage(context, "Category updated successfully");
      } else {
        showSnackBarMessage(context, "Something went wrong", true);
      }
      setState(() {});
      Navigator.pop(context);
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
            child: Text(
          index != null ? "Update category" : "Add new category",
        )),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.themeColor,
          fontFamily: 'Ador',
        ),
        content: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleInputFieldWithIcon(
                  icon: Icons.menu_book_outlined,
                  hint: "Category Name",
                  required: true,
                  controller: categoryNameTEC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Category Name is required";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "বাতিল",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Visibility(
            visible: index == null,
            replacement: TextButton(
              onPressed: onClickUpdate,
              child: Text("আপডেট করুন"),
            ),
            child: TextButton(
              onPressed: onClickSave,
              child: Text("সেভ করুন"),
            ),
          ),
        ],
      );
    },
  );
}
