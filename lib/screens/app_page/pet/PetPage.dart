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
                      PetImage(
                        imgUrl:'', 
                        backgroundColor: Theme.of(context).colorScheme.secondary, 
                        iconColor: Theme.of(context).colorScheme.primary,
                      ),
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
                          Divider(height: 1, color: Theme.of(context).colorScheme.secondary),
                          SizedBox(height: 20),
                          Text('性別:', style: Theme.of(context).textTheme.bodyMedium),
                          Text('種類:', style: Theme.of(context).textTheme.bodyMedium),
                          Text('生日:', style: Theme.of(context).textTheme.bodyMedium),
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
                        color:Theme.of(context).colorScheme.secondary
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
                    child:Icon(
                      record ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color:Theme.of(context).colorScheme.primary
                    ),
                  ), 
                  Text('所有紀錄', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.add, color:Theme.of(context).colorScheme.primary),
                  Text('新增項目', style: Theme.of(context).textTheme.bodyLarge),
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
                      Icon(Icons.water_drop, color: Theme.of(context).colorScheme.secondary, size: 40),
                      SizedBox(width: 8),
                      Text(
                        '飲水量:',
                        style: Theme.of(context).textTheme.bodyMedium
                      )
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
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
                child:Icon(
                  notification ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color:Theme.of(context).colorScheme.primary
                ),
              ), 
              Text('所有通知', style: Theme.of(context).textTheme.bodyLarge),
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
                      Text('2025/1/10', style: Theme.of(context).textTheme.bodyMedium),
                      Text('帶寵物去打疫苗', style: Theme.of(context).textTheme.bodyMedium),
                    ]
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Theme.of(context).colorScheme.secondary),
                ],
              )
            )
          ),
        ],
      )
    );
  }
}