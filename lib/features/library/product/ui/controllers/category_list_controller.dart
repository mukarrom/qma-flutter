import 'package:get/get.dart';
import 'package:qma/features/library/data/models/category_list_model.dart';
import 'package:qma/features/library/data/models/category_model.dart';
import 'package:qma/services/db/db_helper.dart';

class CategoryListController extends GetxController {
  final DbHelper dbHelper = DbHelper.instance;
  bool _isLoading = false;
  CategoryListModel? _categoryListModel;
  List<CategoryModel> categories = [];

  String _errorMessage = "";

  bool get isLoading => _isLoading;
  List<CategoryModel>? get categoryList =>
      _categoryListModel?.categoryList ?? [];
  String get errorMessage => _errorMessage;

  // Future<bool> getCategories({Map<String, dynamic>? query}) async {
  //   bool isSuccess = false;
  //   _isLoading = true;
  //   update();
  //   final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
  //     Urls.getCategories,
  //   );
  //   if (response.isSuccess) {
  //     _categoryListModel = CategoryListModel.fromJson(response.responseData);
  //     isSuccess = true;
  //   } else {
  //     _errorMessage = response.errorMessage;
  //   }
  //   _isLoading = false;
  //   update();
  //   return isSuccess;
  // }

  /// get all categories from local database
  Future<bool> getAllCategories({Map<String, dynamic>? query}) async {
    categories.clear();
    final db = await dbHelper.database;
    bool isSuccess = false;
    _isLoading = true;
    update();

    final data = await db.query(DbHelper.CATEGORY_TABLE_NAME);
    if (data.isNotEmpty) {
      // categories = data.map((e) => CategoryModel.fromJson(e)).toList();
      for (var element in data) {
        categories.add(CategoryModel.fromJson(element));
      }
      isSuccess = true;
    } else {
      _errorMessage = "No data found";
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}
