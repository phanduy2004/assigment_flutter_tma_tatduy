import 'package:hello/core/models/product.dart';

class CartItem {
  final int id;
  final String productId;
  final int quantity;
  final Product product;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      product: Product.fromMap({
        'id': map['productId'],
        'name': map['name'],
        'price': map['price'],
        'imagePath': map['imagePath'],
      }),
    );
  }
}