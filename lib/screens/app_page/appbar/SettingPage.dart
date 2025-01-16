import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('主題'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('字體'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('提醒設定'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('語言設定'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('小工具編輯'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('應用程式啟動分頁'),
              onTap: (){
                //
              },
            ),
            Divider(),
            ListTile(
              leading:  Icon(Icons.article),
              title: Text('帳戶'),
              onTap: (){
                //
              },
            ),
            Divider(),
          ],
        ),
      ),
    ); 
  } 
}