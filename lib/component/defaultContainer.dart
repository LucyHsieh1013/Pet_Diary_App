import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double? height;
  final AlignmentGeometry alignment;
  final Widget? child;
  final Color color;

  const CustomContainer({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.alignment = Alignment.center,
    this.child,
    this.color = Colors.white,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: alignment,
      child: child,
    );
  }
}  

//用於每個頁面的最外層元素，設置為可滾動畫面，避免元素溢出
class ScrollableScaffold  extends StatelessWidget {
  final Widget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final double borderRadius;
  final Color? backgroundColor;


  const ScrollableScaffold ({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.borderRadius = 0,
    this.backgroundColor,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius), // 設置頂部圓角
      ),
    
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar != null
          ?PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: appBar!,
          )
          : null,
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: body,
            )
          ),
          
          floatingActionButton: floatingActionButton != null
            ?floatingActionButton
            :null,
      )
    );
  }
}