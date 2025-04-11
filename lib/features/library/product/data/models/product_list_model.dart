import 'package:qma/features/common/data/model/meta_model.dart';
import 'package:qma/features/library/data/models/product_model.dart';

class ProductListModel {
  bool? success;
  String? message;
  MetaModel? meta;
  List<ProductModel>? productList;

  ProductListModel({this.success, this.message, this.meta, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.productList != null) {
      data['data'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
