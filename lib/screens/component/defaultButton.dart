import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.width = double.infinity,
    required this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Color.fromARGB(255, 213, 213, 213)
          ),
          shadowColor: Colors.grey,
        ),
        onPressed: onPressed,
        child: Text(text),
      )
    );
  }
}