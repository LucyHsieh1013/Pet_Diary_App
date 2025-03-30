import 'package:flutter/material.dart';
import 'package:test_app/screens/app_page/calendar/floatbtnFirst.dart';

class DiaryPage extends StatefulWidget {
  @override
  DiaryScreen createState() => DiaryScreen();
}

class DiaryScreen extends State<DiaryPage> {
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
                color: Theme.of(context).primaryColor,
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
              child: Text('尚無日記', style: Theme.of(context).textTheme.titleLarge),
            )
          ],
        )
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: (){
          FloatbtnFirst(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
  
}

