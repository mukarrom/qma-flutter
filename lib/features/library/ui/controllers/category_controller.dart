import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/data/models/category_list_model.dart';
import 'package:qma/features/library/data/models/category_model.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class CategoryController extends GetxController {
  bool _isLoading = false;
  bool _isSuccess = false;
  CategoryListModel? _categoryListModel;
  CategoryListModel? _deletedCategoryListModel;

  String _errorMessage = "";

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  List<CategoryModel>? get categoryList =>
      _categoryListModel?.categoryList ?? [];
  List<CategoryModel>? get deletedCategoryList =>
      _deletedCategoryListModel?.categoryList ?? [];
  String get errorMessage => _errorMessage;

  Future<bool> getCategories({Map<String, dynamic>? query}) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.getCategories,
    );
    if (response.isSuccess) {
      _categoryListModel = CategoryListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> getDeletedCategories({Map<String, dynamic>? query}) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.getDeletedCategories,
    );
    if (response.isSuccess) {
      _deletedCategoryListModel =
          CategoryListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> addNewCategory({Map<String, dynamic>? body}) async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.createCategory,
      body,
    );
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> updateCategoryById({
    required String categoryId,
    required Map<String, dynamic> body,
  }) async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().patchRequest(
      Urls.updateCategory(categoryId),
      body,
    );
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> moveToDeletedScreenById({required String categoryId}) async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(
      Urls.deleteCategory(categoryId),
    );
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  Future<bool> deleteCategoryForeverById({required String categoryId}) async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(
      Urls.deleteCategoryForever(categoryId),
    );
    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
