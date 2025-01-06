import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    // AppBar底線
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(10.0),
      child: Container(
        height: 1.0,
        color: Colors.grey.withOpacity(0.5),
      ),
    ),

    title: Text('使用者'),
    centerTitle: true,// title至中
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          // 設置按鈕點擊事件
          Navigator.pushNamed(context, '/Setting');
        },
      ),
    ],
  );
}