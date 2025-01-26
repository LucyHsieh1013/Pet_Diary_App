import 'package:flutter/material.dart';
// import 'package:test_app/screens/app_page/appbar/SettingPage.dart';

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
      Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 使用 Builder 小部件包裹 context，以便正確訪問 Scaffold
              Scaffold.of(context).openEndDrawer();
            },
          );
        },
      ),
    ],
  );
}