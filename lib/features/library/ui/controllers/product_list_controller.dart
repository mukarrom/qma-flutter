import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/data/models/product_list_model.dart';
import 'package:qma/features/library/data/models/product_model.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';

class ProductListController extends GetxController {
  bool _isLoading = false;
  ProductListModel? _productListModel;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  List<ProductModel>? get productList => _productListModel?.productList ?? [];
  String get errorMessage => _errorMessage;

  Future<bool> getProducts({Map<String, dynamic>? query}) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.getProducts,
    );
    if (response.isSuccess) {
      _productListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
