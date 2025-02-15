class Urls {
  // static const String _baseUrl = 'https://qmma.vercel.app/api/v1';
  static const String _baseUrl = 'http://localhost:5000/api/v1';

  static const String createCategory = '$_baseUrl/categories';
  static const String getCategories = '$_baseUrl/categories';
  static const String getDeletedCategories = '$_baseUrl/categories/deleted';
  static String updateCategory(String categoryId) =>
      '$_baseUrl/categories/$categoryId';
  static String deleteCategory(String categoryId) =>
      '$_baseUrl/categories/$categoryId';
  static String deleteCategoryForever(String categoryId) =>
      '$_baseUrl/categories/forever/$categoryId';

  static const String getProducts = '$_baseUrl/products';
  static const String createProduct = '$_baseUrl/products';
  static String updateProduct(String productId, [String? query]) =>
      '$_baseUrl/products/$productId?$query';
  static String productBuySell(String productId) =>
      '$_baseUrl/products/total/$productId';
  static String deleteProduct(String productId) =>
      '$_baseUrl/products/$productId';
  static String deleteForeverProduct(String productId) =>
      '$_baseUrl/products/forever/$productId';
}
