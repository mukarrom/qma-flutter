import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/common/ui/widgets/change_alert_dialog.dart';
import 'package:qma/features/common/ui/widgets/snack_bar_message.dart';
import 'package:qma/features/library/data/models/product_model.dart';
import 'package:qma/features/library/ui/controllers/product_buy_sell_controller.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';

class BuySellProducts extends StatefulWidget {
  const BuySellProducts(
      {super.key,
      required this.context,
      required this.isSold,
      required this.index});

  final BuildContext context;
  final bool isSold;
  final int index;

  @override
  State<BuySellProducts> createState() => _BuySellProductsState();
}

class _BuySellProductsState extends State<BuySellProducts> {
  final ProductListController _productListController =
      Get.find<ProductListController>();
  final TextEditingController _quantityController = TextEditingController(
    text: "1",
  );
  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        _productListController.productList![widget.index];
    return AlertDialog(
      title: Center(
          child: Text(widget.isSold
              ? "${product.name} বিক্রি করুন"
              : "${product.name} সংগ্রহ করুন")),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.themeColor,
        fontFamily: 'Ador',
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  int quantity = int.parse(_quantityController.text);
                  if (quantity > 1) {
                    quantity--;
                    _quantityController.text = quantity.toString();
                  }
                });
              },
              icon: Icon(Icons.remove),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: _quantityController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.themeColor,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  int quantity = int.parse(_quantityController.text);
                  quantity++;
                  _quantityController.text = quantity.toString();
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("বাতিল করুন"),
        ),
        TextButton(
          onPressed: () => _onPressedBuySell(context, product),
          child: widget.isSold
              ? const Text("বিক্রি করুন")
              : const Text("সংগ্রহ করুন"),
        ),
      ],
    );
  }

  void _onPressedBuySell(BuildContext context, ProductModel product) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => ChangeAlertDialog(
        title: "${product.name} ${product.category?.name}",
        message:
            "আপনি কি এই প্রোডাক্ট ${_quantityController.text} টি ${widget.isSold ? "বিক্রি করতে" : "সংগ্রহ করতে"} চান?",
        onClickYes: () async {
          bool isSuccess =
              await Get.find<ProductBuySellController>().buySellProduct(
            productId: product.sId!,
            body: widget.isSold
                ? {"sold": int.parse(_quantityController.text)}
                : {"bought": int.parse(_quantityController.text)},
          );
          Navigator.pop(context);
          if (isSuccess) {
            showSnackBarMessage(
                context, "${widget.isSold ? "বিক্রি" : "সংগ্রহ"} করা হয়েছে");
          } else {
            showSnackBarMessage(context,
                Get.find<ProductBuySellController>().errorMessage, true);
          }
        },
      ),
    );
  }
}
