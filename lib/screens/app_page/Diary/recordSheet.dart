import 'package:flutter/material.dart';
// import 'package:test_app/screens/app_page/Diary/floatbtnFirst.dart';
import 'package:test_app/component/defaultSheet.dart';

void RecordSheet(BuildContext context){
  showCustomDialog(
    context,
    "新增",
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.article),
          title: Text('支出'),
          onTap: (){
            //每日記錄頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('飲水量'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('廁所'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('藥物'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('餵食'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('散步'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('體重'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('體溫'),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.black),
          title: Text('情緒辨識'),
          onTap: (){
            //日記頁面
          },
        ),
        // SizedBox(height: 10),
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: (){
        //       Navigator.pop(context);
        //       FloatbtnFirst(context);
        //     }, 
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       side: BorderSide(
        //         color: const Color.fromARGB(255, 195, 195, 195),
        //       ),
        //       shadowColor: Colors.grey,
        //     ),
        //     child: Text(
        //       '取消',
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),  
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
