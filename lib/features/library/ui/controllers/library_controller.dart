import 'package:get/get.dart';
import 'package:qma/features/library/data/models/book_model.dart';

class LibraryController extends GetxController {
  final List<BookModel> _products = [];
  int _quantity = 0;
  final int _buyQuantity = 0;
  final int _sellQuantity = 0;

  List<BookModel> get products => _products;
  int get quantity => _quantity;
  int get buyQuantity => _buyQuantity;
  int get sellQuantity => _sellQuantity;

  void addProduct(BookModel product) {
    _products.add(product);
    update();
  }

  void increaseDecreaseQuantity(int qnt, bool willIncrease) {
    if (willIncrease) {
      _quantity = _quantity + qnt;
    } else {
      _quantity = _quantity - qnt;
    }
    update();
  }

  void updateBoughtQuantity(index, {bool isSold = false}) {
    BookModel product = _products[index];
    if (isSold) {
      product.totalSold = product.totalSold + _quantity;
    } else {
      product.totalBought = product.totalBought + _quantity;
    }
    product.inStock = product.totalBought - product.totalSold;
    update();
  }

  void setSoldQuantity(int quantity) {
    _quantity = quantity;
    update();
  }

  void resetQuantity() {
    _quantity = 0;
    update();
  }
}
