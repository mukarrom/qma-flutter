import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class ProductCreateController extends GetxController {
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;

  Future<bool> createNewProduct(Map<String, dynamic>? body) async {
    _isLoading = true;
    update();
    NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      Urls.createProduct,
      body,
    );

    if (response.isSuccess) {
      _isSuccess = true;
      Get.find<ProductListController>().getProducts();
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
