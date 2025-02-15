class BookModel {
  String productName = "";
  double price = 0.0;
  int totalBought = 0;
  int totalSold = 0;
  int inStock = 0;

  BookModel({
    required this.productName,
    required this.price,
    required this.totalBought,
    required this.totalSold,
    required this.inStock,
  });
}
