import 'package:flutter/material.dart';

// Cấu trúc chung về màu sắc, kích cỡ các button
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;


  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin", color: Colors.white),
        ),
      ),
    );
  }
}
