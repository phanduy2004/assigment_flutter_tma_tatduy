import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/cart/bloc/cart_bloc.dart';
import 'package:hello/feature/layout/cart/bloc/cart_event.dart';
import 'package:hello/feature/layout/cart/bloc/cart_state.dart';

import '../../../widget/custom_bottom_navigavation_bar.dart';

class CartScreen extends StatefulWidget {
  final String username;

  const CartScreen({super.key, required this.username});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: widget.username,
      );
    } else if (index == 2) {
      Navigator.pushReplacementNamed(
        context,
        '/profile',
        arguments: widget.username,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              print(
                "Trạng thái giỏ hàng: ${state.status}, Giỏ hàng: ${state.cartItems}",
              );
              if (state.status == CartStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == CartStatus.error) {
                return Center(
                  child: Text(state.errorMessage ?? 'Lỗi khi tải giỏ hàng'),
                );
              } else if (state.status == CartStatus.success) {
                final cartItems = state.cartItems ?? [];
                if (cartItems.isEmpty) {
                  return const Center(child: Text('Giỏ hàng trống'));
                }
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          cartItem.product.imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(cartItem.productId),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${cartItem.product.price} VNĐ'),
                            Text('Số lượng: ${cartItem.quantity}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Đã xóa ${cartItem.product.name} khỏi giỏ hàng',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text('Không có dữ liệu giỏ hàng'));
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
