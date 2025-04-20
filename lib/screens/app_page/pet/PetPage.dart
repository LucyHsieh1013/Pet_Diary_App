import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/component/circleImage.dart';
import 'package:test_app/provider/PetInformation.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screens/app_page/Pet/floatbtnFirst.dart';

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
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        circleImage(
                          imgUrl: '', 
                          backgroundColor: Theme.of(context).colorScheme.secondary, 
                          iconColor: Theme.of(context).colorScheme.primary,
                          piciconColor: Theme.of(context).colorScheme.primary
                        ),
                        SizedBox(width: 20),
                        Consumer<PetProvider>(
                          builder: (context, petProvider, child) {
                            return Text(
                              petProvider.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(microseconds: 300),
                      crossFadeState: isExpended ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(height: 1, color: Theme.of(context).colorScheme.secondary),
                            SizedBox(height: 20),
                            Consumer<PetProvider>(
                              builder: (context, petProvider, child) {
                                return Text(
                                  '性別: ${petProvider.gender}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            ),
                            Consumer<PetProvider>(
                              builder: (context, petProvider, child) {
                                return Text(
                                  '種類: ${petProvider.variety}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            ),
                            Consumer<PetProvider>(
                              builder: (context, petProvider, child) {
                                return Text(
                                  '生日: ${petProvider.birthday}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpended = !isExpended;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          isExpended ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: -10,
                  top: -10,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit_square,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/Addform',
                        arguments: {'isEditing': true},//編輯
                      );
                    },
                  ),
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
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
        onPressed: (){
          FloatbtnFirst(context); //底部跳出視窗(日記、數據紀錄)
        },
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
    
  }
}