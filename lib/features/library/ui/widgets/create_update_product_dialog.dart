import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/single_fileld_with_icon_widget.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/product_create_controller.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';
import 'package:qma/features/library/ui/controllers/product_update_controller.dart';
import 'package:qma/features/students/ui/widgets/single_input_field_with_icon.dart';

class CreateUpdateProductDialog extends StatefulWidget {
  const CreateUpdateProductDialog({super.key, this.index});

  final int? index;

  @override
  State<CreateUpdateProductDialog> createState() =>
      _CreateUpdateProductDialogState();
}

class _CreateUpdateProductDialogState extends State<CreateUpdateProductDialog> {
  final ProductListController _productListController =
      Get.find<ProductListController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();

  String _selectedValue = '';

  final List<DropdownMenuEntry> _dropdownMenuEntries =
      Get.find<CategoryListController>()
          .categoryList!
          .map(
            (category) => DropdownMenuEntry(
              label: category.name!,
              value: category.sId,
            ),
          )
          .toList();

  @override
  void initState() {
    if (widget.index != null) {
      _selectedValue = _productListController
              .productList?[widget.index ?? 0].category!.sId ??
          '';
      _productNameController.text =
          _productListController.productList?[widget.index ?? 0].name ?? '';
      _productPriceController.text = _productListController
              .productList?[widget.index ?? 0].price
              .toString() ??
          '';
      _productDescriptionController.text =
          _productListController.productList?[widget.index ?? 0].description ??
              '';
      _productCategoryController.text = _productListController
              .productList?[widget.index ?? 0].category?.sId ??
          '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: widget.index != null
            ? Text("প্রোডাক্ট আপডেট করুন")
            : Text("নতুন প্রোডাক্ট যুক্ত করুন"),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.themeColor,
        fontFamily: 'Ador',
      ),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // product name
              SingleInputFieldWithIcon(
                icon: Icons.menu_book_outlined,
                hint: "প্রোডাক্টের নাম",
                required: true,
                controller: _productNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "প্রোডাক্টের নাম প্রয়োজন";
                  }
                  return null;
                },
              ),

              // product details
              SingleInputFieldWithIcon(
                icon: Icons.menu_book_outlined,
                hint: "প্রোডাক্টের ডিটেইলস",
                controller: _productDescriptionController,
              ),

              // product price
              SingleInputFieldWithIcon(
                icon: Icons.attach_money_outlined,
                hint: "মূল্য",
                required: true,
                controller: _productPriceController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "প্রোডাক্টের মূল্য প্রয়োজন";
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(),
              ),

              // Category
              SingleFieldWithIconWidget(
                icon: Icons.category_outlined,
                child: DropdownMenu(
                  dropdownMenuEntries: _dropdownMenuEntries,
                  inputDecorationTheme: InputDecorationTheme(),
                  width: double.infinity,
                  controller: _productCategoryController,
                  initialSelection: _productCategoryController.text,
                  label: Text(
                    "Category",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onSelected: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedValue = value;
                        _productCategoryController.text = value;
                      });
                    }
                  },
                ),
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
          child: const Text(
            "বাতিল",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: _onClickSave,
          child: const Text("সেভ করুন"),
        ),
      ],
    );
  }

  Future<void> _onClickSave() async {
    bool isSuccess = false;
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> requestData = {
        "name": _productNameController.text,
        "price": int.parse(_productPriceController.text),
        "description": _productDescriptionController.text,
        "category": _selectedValue,
      };

      if (widget.index != null) {
        isSuccess =
            await Get.find<ProductUpdateController>().updateCategoryById(
          productId:
              _productListController.productList?[widget.index!].sId ?? "",
          body: requestData,
          query:
              "categoryId=${_productListController.productList?[widget.index!].category!.sId}",
        );
      } else {
        isSuccess = await Get.find<ProductCreateController>()
            .createNewProduct(requestData);
        // print(requestData);
      }
      if (isSuccess) {
        _clearFields();
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            Get.find<ProductCreateController>().errorMessage,
            true,
          );
        }
      }
    }
  }

  void _clearFields() {
    _productNameController.clear();
    _productPriceController.clear();
    _productDescriptionController.clear();
    _productCategoryController.clear();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productDescriptionController.dispose();
    _productCategoryController.dispose();
    super.dispose();
  }
}
