import 'package:flutter/material.dart';
import 'package:test_app/screens/app_page/appbar/ThemeOption.dart';
import 'package:test_app/screens/app_page/appbar/Language.dart';
import 'package:test_app/services/Token.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:test_app/services/provider.dart';
import 'package:test_app/component/PetImg.dart';

Drawer SettingDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero, 
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 176, 124),//導覽列背景顏色
            border: const Border(bottom: BorderSide.none),
          ),
          accountName: Consumer<UserProvider>(
            builder: (context, userProvider, child){
              print('username: ${userProvider.username}');
              return Text(userProvider.username);
            }
          ),
          accountEmail: Consumer<UserProvider>(
            builder: (context, userProvider, child){
              print('useremail: ${userProvider.useremail}');
              return Text(userProvider.useremail);
            }
          ),
          currentAccountPicture: PetImage(
            imgUrl:'', 
            backgroundColor: Theme.of(context).colorScheme.secondary, 
            iconColor: Theme.of(context).colorScheme.primary,
            defaultIcon: Icons.person,
          ),
        ),
        ListTile(
          leading:  Icon(Icons.article),
          title: Text('修改密碼'),
          onTap: (){
            //
          },
        ),
        ListTile(
          leading:  Icon(Icons.palette),
          title: Text('主題'),
          onTap: (){
            ThemeSheet(context);
          },
        ),
        ListTile(
          leading:  Icon(Icons.language),
          title: Text('語言設定'),
          onTap: (){
            LanguageSheet(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('登出'),
          onTap: () {
            showAlert(context);
          },
        ),
      ],
    ),
  );
}
Future<void> showAlert(BuildContext context) async{
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('確定要登出嗎?'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('確定'),
            onPressed: () async{
              resetAllProviders(context); //重置provider
              await removeToken(); //刪除token
              String? afterdeletetoken = await getToken();
              print('刪除後的token: ${afterdeletetoken}');
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      );
    },
  );
}