import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/data/models/category_list_model.dart';
import 'package:qma/features/library/data/models/category_model.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class DeletedCategoryListController extends GetxController {
  bool _isLoading = false;
  CategoryListModel? _deletedCategoryListModel;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  List<CategoryModel>? get deletedCategoryList =>
      _deletedCategoryListModel?.categoryList ?? [];
  String get errorMessage => _errorMessage;

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
}
