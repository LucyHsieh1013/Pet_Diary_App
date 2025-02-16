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
          leading: Icon(Icons.article, color: Theme.of(context).colorScheme.primary),
          title: Text('支出', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //每日記錄頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('飲水量', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('廁所', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('藥物', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('餵食', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('散步', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('體重', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('體溫', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          title: Text('情緒辨識',style: Theme.of(context).textTheme.bodyLarge),
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
