import '../../../../core/models/cart_item.dart';

enum CartStatus { initial, loading, success, error }

class CartState {
  final CartStatus status;
  final List<CartItem> cartItems;
  final String? errorMessage;

  CartState({
    this.status = CartStatus.initial,
    this.cartItems = const [],
    this.errorMessage,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}