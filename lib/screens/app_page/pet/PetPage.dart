import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/component/PetImg.dart';

class PetPage extends StatefulWidget{
  @override
  PetPageScreen createState() => PetPageScreen();
}
class PetPageScreen extends State<PetPage> {
  bool isExpended = false;
  bool record = false;
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainer(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      PetImage(imgUrl: ''),
                      SizedBox(width: 20,),
                      Text('寵物名',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  
                  AnimatedCrossFade(
                    duration: const Duration(microseconds: 300),
                    crossFadeState: isExpended ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 1, color: Colors.brown),
                          SizedBox(height: 20),
                          Text('性別:'),
                          Text('種類:'),
                          Text('生日:'),
                        ],
                      )
                  ),
                ),
                  
                  InkWell(
                    onTap:() {
                      setState((){
                        isExpended = !isExpended;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        isExpended ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
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
                        record = !record;
                      });
                    },
                    child:Icon(record ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                  ), 
                  Text('所有紀錄'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.add),
                  Text('新增項目'),
                ],
              ),
            ],
          ),
          
          CustomContainer(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: Colors.blue, size: 40),
                      SizedBox(width: 8),
                      Text(
                        '飲水量:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ) 
            )
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              InkWell(
                onTap:() {
                  setState(() {
                    notification = !notification;
                  });
                },
                child:Icon(notification ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ), 
              Text('所有通知'),
            ],
          ),
          CustomContainer(
            alignment: Alignment.centerLeft,
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2025/1/10'),
                      Text('帶寵物去打疫苗'),
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right),
                ],
              )
            )
          ),
        ],
      )
    );
  }
}