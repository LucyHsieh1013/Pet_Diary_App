import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';

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

    title: Consumer<UserProvider>(
      builder: (context, userProvider, child){
        print('username: ${userProvider.username}');
        return Text(userProvider.username);
      }
    ),
    centerTitle: true,// title至中
    actions: [
      Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        },
      ),
    ],
  );
}