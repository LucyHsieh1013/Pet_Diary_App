import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultContainer.dart';
import 'package:test_app/screens/app_page/Diary/floatbtnFirst.dart';


void RecordSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return Padding(
          padding: const EdgeInsets.all(20),
          child : ScrollableScaffold(
            borderRadius: 16,
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '新增',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      FloatbtnFirst(context);
                    }, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 195, 195, 195),
                      ),
                      shadowColor: Colors.grey,
                    ),
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Colors.black,
                      ),  
                    ),
                  ),
                ),
              ],
            ),
          )
          
        );
      }
    );
  }