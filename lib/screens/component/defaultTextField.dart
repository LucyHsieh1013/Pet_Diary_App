import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool haveborder; //是否套用圓框
  final Widget? suffixIcon; //Icon
  final bool obscureText; //是否隱藏文字
  final Function(String) onChanged;
  final String? errorText;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.haveborder = false,
    this.obscureText = false,
    this.suffixIcon,
    required this.onChanged,
    this.errorText,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: haveborder
            ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )
            : UnderlineInputBorder(),
          suffixIcon: suffixIcon,
          errorText: errorText,
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}