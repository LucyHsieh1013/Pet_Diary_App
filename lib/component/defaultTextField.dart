import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool haveborder; //是否套用圓框
  final Widget? suffixIcon; //Icon
  final bool obscureText; //是否隱藏文字
  final Function(String) onChanged;
  final String? errorText;
  final String? Function(String?)? validator; // 驗證函式
  final TextEditingController? controller;
  final double borderRadiusValue;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.haveborder = false,
    this.obscureText = false,
    this.suffixIcon,
    required this.onChanged,
    this.errorText,
    this.validator,
    this.controller,
    this.borderRadiusValue = 30.0,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: haveborder
            ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            )
            : UnderlineInputBorder(),
          focusedBorder: haveborder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue),
                borderSide: BorderSide(color: Colors.black, width: 2), // 設定選取時的邊框顏色
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2), // 設定選取時的底線顏色
              ),
          suffixIcon: suffixIcon,
          errorText: errorText,
        ),
        onChanged: (value) {
          onChanged(value);
        },
        validator: validator,
      ),
    );
  }
}