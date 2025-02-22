import 'package:flutter/material.dart';

class ThemeContainer extends StatelessWidget {
  const ThemeContainer({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.width = 42,
    this.height = 42,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10), // 圓角
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
            ],
            border: isSelected
                ? Border.all(
                    width: 4,
                    color: Colors.white, // 選取時的邊框顏色
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
