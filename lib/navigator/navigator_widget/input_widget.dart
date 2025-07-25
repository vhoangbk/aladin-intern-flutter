import 'package:flutter/material.dart';

Widget buildInput({
  required Icon icon,
  required String hint,
  required TextEditingController controller,
  bool obscure = false,
}) {
  return _InputField(
    icon: icon,
    hint: hint,
    controller: controller,
    obscure: obscure,
  );
}

// Đặc tính chung của các ô nhập thông tin
class _InputField extends StatefulWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool obscure;

  const _InputField({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.obscure,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.icon,    //icon
          hintText: widget.hint,   // text lồng trong ô
          hintStyle: const TextStyle(color: Colors.grey),  // màu nền
          filled: true,   // dùng với password
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.obscure
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },

                  // Tao con mat cho phan password
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
