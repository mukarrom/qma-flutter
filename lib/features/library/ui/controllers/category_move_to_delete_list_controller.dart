import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class CategoryMoveToDeleteListController extends GetxController {
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;

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
}
