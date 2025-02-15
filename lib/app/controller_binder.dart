import 'package:get/get.dart';
import 'package:qma/features/library/ui/controllers/category_controller.dart';
import 'package:qma/features/library/ui/controllers/category_create_controller.dart';
import 'package:qma/features/library/ui/controllers/category_delete_forever_controller.dart';
import 'package:qma/features/library/ui/controllers/category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/category_move_to_delete_list_controller.dart';
import 'package:qma/features/library/ui/controllers/category_restore_controller.dart';
import 'package:qma/features/library/ui/controllers/category_update_controller.dart';
import 'package:qma/features/library/ui/controllers/deleted_category_list_controller.dart';
import 'package:qma/features/library/ui/controllers/product_buy_sell_controller.dart';
import 'package:qma/features/library/ui/controllers/product_create_controller.dart';
import 'package:qma/features/library/ui/controllers/product_list_controller.dart';
import 'package:qma/features/library/ui/controllers/product_update_controller.dart';
import 'package:qma/features/sidebar/ui/controllers/nav_controller.dart';
import 'package:qma/services/network/network_caller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NavController());
    Get.put(NetworkCaller());
    Get.put(CategoryListController());
    Get.put(DeletedCategoryListController());
    Get.put(CategoryUpdateController());
    Get.put(CategoryDeleteForeverController());
    Get.put(CategoryCreateController());
    Get.put(CategoryRestoreController());
    Get.put(CategoryMoveToDeleteListController());
    Get.put(CategoryController());
    Get.put(ProductListController());
    Get.put(ProductCreateController());
    Get.put(ProductUpdateController());
    Get.put(ProductBuySellController());
  }
}
