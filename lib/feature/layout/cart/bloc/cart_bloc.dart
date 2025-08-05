import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/cart/bloc/cart_event.dart';
import 'package:hello/feature/layout/cart/bloc/cart_state.dart';

import '../../../../sqlite/database_helper.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final DatabaseHelper databaseHelper;

  CartBloc({required this.databaseHelper}) : super(CartState()) {
    on<AddToCartEvent>(_onAddToCartEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent);
    on<LoadCartEvent>(_onLoadCartEvent);
  }

  Future<void> _onAddToCartEvent(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await databaseHelper.addToCart(
        productId: event.productId,
        quantity: event.quantity,
      );
      final cartItems = await databaseHelper.getCartItems();
      emit(state.copyWith(status: CartStatus.success, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onRemoveFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      await databaseHelper.removeFromCart(event.productId);
      final cartItems = await databaseHelper.getCartItems();
      emit(state.copyWith(status: CartStatus.success, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadCartEvent(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    try {
      final cartItems = await databaseHelper.getCartItems();
      emit(state.copyWith(status: CartStatus.success, cartItems: cartItems));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, errorMessage: e.toString()));
    }
  }
}