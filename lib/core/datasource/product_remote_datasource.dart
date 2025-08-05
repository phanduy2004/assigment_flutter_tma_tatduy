import 'package:hello/core/models/product.dart';
import 'package:hello/sqlite/database_helper.dart';

class ProductRemoteDatasource {
  final DatabaseHelper databaseHelper;
  ProductRemoteDatasource({required this.databaseHelper});
  /// Lấy danh sách sản phẩm từ cơ sở dữ liệu SQLite.
  Future<List<Product>> getProducts() async {
    try {
      final productMaps = await databaseHelper.getProducts();
      return productMaps.map((map) => Product.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Lỗi khi lấy sản phẩm từ SQLite: $e');
    }
  }
}