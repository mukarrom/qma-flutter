import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/data/models/category_list_model.dart';
import 'package:qma/features/library/data/models/category_model.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class CategoryListController extends GetxController {
  bool _isLoading = false;
  CategoryListModel? _categoryListModel;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  List<CategoryModel>? get categoryList =>
      _categoryListModel?.categoryList ?? [];
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
}
