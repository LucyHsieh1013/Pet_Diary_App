import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart'; // CustomContainer 在這裡定義
// import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/circleImage.dart';

class StoreDetile extends StatefulWidget {
  @override
  State<StoreDetile> createState() => _StoreDetileState();
}

class _StoreDetileState extends State<StoreDetile> {
  bool isExpended = false;
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商家詳情'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      body: ScrollableScaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,// 隨內文縮放高度
                      children: [
                        circleImage(
                          imgUrl: '', 
                          backgroundColor: Theme.of(context).colorScheme.secondary, 
                          iconColor: Theme.of(context).colorScheme.primary,
                          piciconColor: Theme.of(context).colorScheme.primary
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('商家名稱'),
                              Text('類別:'),
                              Text('地址:'),
                              Text('服務項目:'),
                              Text('備註:'),
                              Text('官網:'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap:() {
                        setState(() {
                          notification = !notification;
                        });
                      },
                      child:Icon(
                        notification ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color:Theme.of(context).colorScheme.primary
                      ),
                    ), 
                    Text('消息', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ],
            ),
            CustomContainer( // 消息框
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('內文'),
                        //可再加入其他內容
                      ],
                    ),
                  ]
                )
              ),
            ),
            //可再添加消息欄位(CustomContainer)
          ],
        )
      )
    );
  }
}
