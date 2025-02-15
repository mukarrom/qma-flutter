import 'package:qma/features/library/data/models/category_model.dart';

class ProductModel {
  String? sId;
  String? name;
  String? description;
  int? price;
  String? image;
  CategoryModel? category;
  List<String>? tags;
  int? totalBought;
  int? totalSold;
  int? inStock;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.sId,
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.tags,
    this.totalBought,
    this.totalSold,
    this.inStock,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    category = CategoryModel.fromJson(json['category']);
    tags = json['tags'].cast<String>();
    totalBought = json['totalBought'];
    totalSold = json['totalSold'];
    inStock = json['inStock'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['category'] = category!.toJson();
    data['tags'] = tags;
    data['totalBought'] = totalBought;
    data['totalSold'] = totalSold;
    data['inStock'] = inStock;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
