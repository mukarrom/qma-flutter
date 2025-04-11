import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final ProductListController productList = Get.find<ProductListController>();
    final product = productList.productList![index];
    return Scaffold(
      appBar: AppBar(
        title: Text("প্রোডাক্ট ডিটেইলস"),
      ),
      body: Column(
        children: [
          Image.network(
            "https://d1c2pjf7x5h5mh.cloudfront.net/sites/files/openschoolbag/productimg/201511/360x511/learning_english_nursery.jpg",
            width: double.infinity,
            height: 300,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            "প্রোডাক্টের নাম: ${productList.productList?[index].name}" ?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Add more product details here
          Text("মূল্য: ৳${product.price} টাকা"),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(border: TableBorder.all(), children: [
              // total bought
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "সর্বমোট কেনা হয়েছে ${product.totalBought} টি",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${product.totalBought! * (product.price!)} টাকা",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "সর্বমোট বেচা হয়েছে ${product.totalSold} টি",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${product.totalSold! * product.price!} টাকা",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "সর্বমোট স্টকে আছে ${product.inStock} টি",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "${product.inStock! * product.price!} টাকা",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}
