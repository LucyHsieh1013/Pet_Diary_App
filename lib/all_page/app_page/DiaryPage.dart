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
          print('浮動標籤');
        },
        backgroundColor: const Color.fromARGB(255, 232, 176, 124),
      ),
    );
  }
}