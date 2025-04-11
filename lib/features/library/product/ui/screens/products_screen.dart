import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/app/app_colors.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';
import 'package:qma/features/library/ui/screens/product_details_screen.dart';
import 'package:qma/features/library/ui/widgets/buy_sell_products.dart';
import 'package:qma/features/library/ui/widgets/create_update_product_dialog.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductListController _productListController =
      Get.find<ProductListController>();
  int quantity = 0;
  Offset _tapPosition = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          onPressed: () => _onClickCreateUpdateProduct(),
          icon: Icon(Icons.add),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.themeColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          tooltip: "নতুন প্রোডাক্ট তৈরি করুন",
        ),
        title: Text("প্রোডাক্ট সমূহ"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<ProductListController>(
        builder: (controller) {
          return ListView.separated(
            itemCount: controller.productList?.length ?? 0,
            itemBuilder: (context, index) {
              return Material(
                elevation: 8,
                child: GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _tapPosition = details.globalPosition;
                    });
                  },
                  onLongPressDown: (details) {
                    setState(() {
                      _tapPosition = details.globalPosition;
                    });
                  },
                  child: ListTile(
                    onLongPress: () =>
                        _onClickThreeDots(index, context, _tapPosition),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              index: index,
                            );
                          },
                        ),
                      );
                    },
                    leading: Image.network(
                      "https://d1c2pjf7x5h5mh.cloudfront.net/sites/files/openschoolbag/productimg/201511/360x511/learning_english_nursery.jpg",
                      width: 40,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Row(
                      spacing: 16,
                      children: [
                        Text(
                          controller.productList?[index].name ?? "",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "মূল্য: ৳${controller.productList?[index].price ?? 0}"),
                      ],
                    ),
                    subtitle: Row(
                      spacing: 16,
                      children: [
                        Text(controller.productList?[index].category?.name ??
                            ""),
                        (controller.productList?[index].inStock ?? 0) < 1
                            ? Text(
                                "স্টকে নেই",
                                style: TextStyle(color: Colors.red),
                              )
                            : Text(
                                "স্টকে আছে: ${controller.productList?[index].inStock}",
                                style: TextStyle(
                                  color:
                                      controller.productList![index].inStock! <
                                              5
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () =>
                          _onClickThreeDots(index, context, _tapPosition),
                      icon: Icon(
                        Icons.more_vert_outlined,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {},
        tooltip: "Sell a product",
        foregroundColor: Colors.white,
        child: Icon(Icons.sell_outlined),
      ),
    );
  }

  void _onClickCreateUpdateProduct([int? index]) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateUpdateProductDialog(index: index);
      },
    );
  }

  Future<String?> _onClickThreeDots(
    int index,
    BuildContext context,
    Offset tapPosition,
  ) {
    return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx,
        tapPosition.dy,
      ),
      items: [
        // বিক্রি করুন
        PopupMenuItem(
          onTap: () => _onClickBuySellProduct(
            context,
            index,
            isSold: true,
          ),
          value: 'details',
          child: Text('বিক্রি করুন'),
        ),

        // কিনুন
        PopupMenuItem(
          onTap: () => _onClickBuySellProduct(
            context,
            index,
            isSold: false,
          ),
          value: 'details',
          child: Text('সংগ্রহ করুন'),
        ),

        // সংশোধন করুন
        PopupMenuItem(
          onTap: () => _onClickCreateUpdateProduct(index),
          value: 'details',
          child: Text('সংশোধন করুন'),
        ),

        // ডিলিট করুন
        PopupMenuItem(
          onTap: () => _onClickDeleteProduct(index, context, setState),
          value: 'details',
          child: Text(
            'ডিলিট করুন',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  void _onClickBuySellProduct(BuildContext context, int index,
      {bool isSold = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return BuySellProducts(
          context: context,
          index: index,
          isSold: isSold,
        );
      },
    );
  }

  Future<String?> _onClickDeleteProduct(int index, BuildContext context,
      void Function(VoidCallback fn) setState) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(_productListController.productList![index].name!),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "আপনি কি এটা ডিলিট করতে চান?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontFamily: 'Ador',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("না")),
              TextButton(
                  onPressed: () {
                    _productListController.productList?.removeAt(index);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("হ্যাঁ", style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }
}


