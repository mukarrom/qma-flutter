import 'package:qma/features/common/data/model/meta_model.dart';
import 'package:qma/features/library/data/models/category_model.dart';

class CategoryListModel {
  bool? success;
  String? message;
  MetaModel? meta;
  List<CategoryModel>? categoryList;

  CategoryListModel({this.success, this.message, this.meta, this.categoryList});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      categoryList = <CategoryModel>[];
      json['data'].forEach((v) {
        categoryList!.add(CategoryModel.fromJson(v));
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
    if (categoryList != null) {
      data['data'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
