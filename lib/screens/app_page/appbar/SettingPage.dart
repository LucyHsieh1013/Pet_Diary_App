import 'package:flutter/material.dart';
// import 'package:test_app/screens/component/defaultContainer.dart';
import 'package:test_app/screens/app_page/appbar/ThemeOption.dart';

Drawer SettingDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 232, 176, 124),//導覽列背景顏色
          ),
          accountName: Text('使用者名稱'),
          accountEmail: Text('user@example.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue),
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
            //
          },
        ),
        // ListTile(
        //   leading:  Icon(Icons.article),
        //   title: Text('字體'),
        //   onTap: (){
        //     //
        //   },
        // ),
        // ListTile(
        //   leading:  Icon(Icons.article),
        //   title: Text('小工具編輯'),
        //   onTap: (){
        //     //
        //   },
        // ),
        // ListTile(
        //   leading:  Icon(Icons.article),
        //   title: Text('帳戶'),
        //   onTap: (){
        //     //
        //   },
        // ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('登出'),
          onTap: () {
            // 處理登出點擊事件
            // Navigator.pop(context);
            showAlert(context);
          },
        ),
      ],
    ),
  );
}
Future<void> showAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('確定要登出嗎?'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('確定'),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      );
    },
  );
}
// class SettingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScrollableScaffold(
//       appBar: AppBar(
//         title: Text('設定'),
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(10.0),
//           child: Container(
//             height: 1.0,
//             color: Colors.grey.withOpacity(0.5),
//           ),
//         ),
//       ),
      
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('修改密碼'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('主題'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('字體'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('提醒設定'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('語言設定'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('小工具編輯'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('應用程式啟動分頁'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading:  Icon(Icons.article),
//               title: Text('帳戶'),
//               onTap: (){
//                 //
//               },
//             ),
//             Divider(),
//           ],
//         ),
//       ),
//     ); 
//   } 
// }