class CategoryModel {
  String? sId;
  int? id;
  String? name;
  String? image;
  int? totalProducts;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.sId,
      this.id,
      this.name,
      this.image,
      this.totalProducts,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalProducts = json['totalProducts'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['totalProducts'] = totalProducts;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
