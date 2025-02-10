//登入註冊專用，不受主題影響
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // 背景顏色
          foregroundColor: textColor,
          side: const BorderSide(
            color: Color.fromARGB(255, 213, 213, 213)
          ),
          shadowColor: Colors.grey,
        ),
        onPressed: onPressed,
        child: Text(text,style: TextStyle(color: textColor)),
      )
    );
  }
}