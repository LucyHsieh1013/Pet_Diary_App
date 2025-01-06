import 'package:flutter/material.dart';

class DiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 232, 176, 124),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book, color: Colors.white, size: 50),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text('尚無日記', style: TextStyle(fontSize: 20),),
            )
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: (){
          showmodel(context);
        },
        backgroundColor: const Color.fromARGB(255, 232, 176, 124),
      ),
    );
  }
  void showmodel(BuildContext context){
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
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
        );
      }
    );
  }
}

