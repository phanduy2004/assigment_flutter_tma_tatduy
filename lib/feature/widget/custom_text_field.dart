import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final double maxHeight;
  final double labelFontSize;
  final Color labelColor;
  final EdgeInsets contentPadding;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.maxHeight = 40.0,
    this.labelFontSize = 14.0,
    this.labelColor = const Color(0xFF006241),
    this.contentPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.borderRadius = 20.0,
    this.textStyle,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: labelFontSize,
            color: labelColor,
          ),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFF006241)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Color(0xFF006241),
              width: 2,
            ),
          ),
        ),
        style: textStyle ?? const TextStyle(fontSize: 14),
      ),
    );
  }
}