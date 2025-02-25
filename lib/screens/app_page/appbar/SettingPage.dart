import 'package:flutter/material.dart';
import 'package:test_app/screens/app_page/appbar/ThemeOption.dart';
import 'package:test_app/screens/app_page/appbar/Language.dart';
import 'package:test_app/screens/app_page/appbar/password.dart';
import 'package:test_app/services/Token.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:test_app/services/provider.dart';
import 'package:test_app/component/circleImage.dart';  

Drawer SettingDrawer(BuildContext context) {
  return Drawer(
    child: Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero, 
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, // 導覽列背景顏色
              ),
              accountName: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  print('username: ${userProvider.username}');
                  return Text(userProvider.username);
                }
              ),
              accountEmail: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  print('useremail: ${userProvider.useremail}');
                  return Text(userProvider.useremail);
                }
              ),
              currentAccountPicture: circleImage(
                imgUrl: '', 
                backgroundColor: Theme.of(context).colorScheme.secondary, 
                iconColor: Theme.of(context).colorScheme.primary,
                defaultIcon: Icons.person,
                piciconColor: Theme.of(context).colorScheme.primary
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary),
              title: Text('修改密碼', style: Theme.of(context).textTheme.bodyLarge),
              onTap: (){
                password(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
              title: Text('主題', style: Theme.of(context).textTheme.bodyLarge),
              onTap: (){
                ThemeSheet(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
              title: Text('語言設定', style: Theme.of(context).textTheme.bodyLarge),
              onTap: (){
                LanguageSheet(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Theme.of(context).colorScheme.primary),
              title: Text('登出', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                showAlert(context);
              },
            ),
          ],
        ),

        Positioned(
          top: 40, // 調整按鈕高度
          right: 16, // 距離右側 16px
          child: IconButton(
            icon: Icon(
              Icons.edit_square,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ), 
            onPressed: () {
              print("點擊編輯按鈕");
              Navigator.pushNamed(context, '/Updateform');
            },
          ),
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
        content: Text('確定要登出嗎?', style: Theme.of(context).textTheme.bodyLarge),
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