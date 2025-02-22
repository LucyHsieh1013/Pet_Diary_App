import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart'; // CustomContainer在這裡定義

class Explorelist extends StatefulWidget {
  @override
  State<Explorelist> createState() => _ExplorelistState();
}

class _ExplorelistState extends State<Explorelist> {
  
  @override
  Widget build(BuildContext context) {
    // 從ExplorePage.dart接收標題
    final String title = ModalRoute.of(context)!.settings.arguments as String? ?? '預設標題';

    return ScrollableScaffold(
      appBar: AppBar(
        title: Text(
          title, // 標題
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // 第一個訊息框
            CustomContainer(
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '', // 內文
                          style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                    ),
                    Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
                  ],
                ) 
              )
            ),
            SizedBox(height: 20),
            // 第二個訊息框
            CustomContainer(
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '', // 內文
                          style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                    ),
                    Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
                  ],
                ) 
              )
            ),
          ],
        ),
      ),
    );
  }
}