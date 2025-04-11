import 'package:get/get.dart';
import 'package:qma/app/urls.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/services/db/db_helper.dart';
import 'package:qma/services/network/network_caller.dart';
import 'package:qma/services/network/network_response.dart';
import 'package:sqflite/sqflite.dart';

class CategoryCreateController extends GetxController {
  final dbHelper = DbHelper.instance;
  final NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;

  Future<bool> addCategory({Map<String, dynamic>? body}) async {
    final db = await dbHelper.database;
    _isLoading = true;
    update();
    final data = await db.insert(
      DbHelper.CATEGORY_TABLE_NAME,
      body!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (data > 0) {
      print(data);
      _isSuccess = true;
    } else {
      _errorMessage = "Failed to add category";
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<bool> createNewCategory({Map<String, dynamic>? body}) async {
    _isLoading = true;
    update();

    final NetworkResponse response =
        await Get.find<NetworkCaller>().postRequest(
      Urls.createCategory,
      body,
    );
    if (response.isSuccess) {
      Get.find<CategoryListController>().getAllCategories();
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
