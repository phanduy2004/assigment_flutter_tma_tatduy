import 'package:flutter/material.dart';

import '../../core/theme/app_color.dart';

// Widget chung cho button
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final double borderRadius;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.onSurface, // Màu xanh Starbucks
    this.textColor = AppColors.starbucksGreen,
    this.fontSize = 16.0, // Giảm kích thước chữ một chút để trông nhẹ nhàng
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Giảm padding
    this.borderRadius = 6.0, // Giảm độ cong viền
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal, // Chữ mỏng hơn (thay bold bằng normal)
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}