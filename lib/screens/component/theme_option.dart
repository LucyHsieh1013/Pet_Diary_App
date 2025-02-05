import 'package:flutter/material.dart';

class ThemeContainer extends StatelessWidget{
  const ThemeContainer({
    super.key,
    required this.color,
  });
  // const ThemeOption({
  //   Key key,
  //   this.color,
  // }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 42,
          height: 42,
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),
        ),
      ),
      onTap: () {},
    );
  }
}