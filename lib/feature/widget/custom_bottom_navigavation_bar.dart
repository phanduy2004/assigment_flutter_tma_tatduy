import 'package:flutter/material.dart';

import '../../core/theme/app_color.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Giỏ hàng',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hồ sơ'),
      ],
      selectedItemColor: AppColors.starbucksGreen,
      unselectedItemColor: Colors.grey,
    );
  }
}
