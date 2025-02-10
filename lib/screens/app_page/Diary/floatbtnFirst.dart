import 'package:flutter/material.dart';
import 'package:test_app/screens/app_page/Diary/recordSheet.dart';
import 'package:test_app/component/defaultButton.dart';

void FloatbtnFirst(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Padding(
          padding: const EdgeInsets.all(10),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.article),
                title: Text('每日記錄'),
                onTap: (){
                  //每日記錄頁面
                  Navigator.pop(context);
                  RecordSheet(context);
                },
                
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.black),
                title: Text('日記'),
                onTap: (){
                  //日記頁面
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: '取消',
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: (){
              //       Navigator.pop(context);
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
    );
  }