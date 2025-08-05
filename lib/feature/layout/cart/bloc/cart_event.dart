abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productId;
  final int quantity;

  AddToCartEvent({required this.productId, this.quantity = 1});
}

class RemoveFromCartEvent extends CartEvent {
  final String productId;

  RemoveFromCartEvent({required this.productId});
}

class LoadCartEvent extends CartEvent {}