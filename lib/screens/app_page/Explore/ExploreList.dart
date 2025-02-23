import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart'; // CustomContainer 在這裡定義
import 'package:test_app/component/defaultButton.dart';

class Explorelist extends StatefulWidget {
  @override
  State<Explorelist> createState() => _ExplorelistState();
}

class _ExplorelistState extends State<Explorelist> {
  @override
  Widget build(BuildContext context) {
    // 從 ExplorePage.dart 接收標題
    final String title = ModalRoute.of(context)!.settings.arguments as String? ?? '預設標題';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      
      body: Column(
        children: [
          // 按鈕區域
          SizedBox(
            height: 60, // 按鈕高度
            child: ListView(
              scrollDirection: Axis.horizontal, // 橫向滾動
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕1',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕2',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕3',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕4',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕5',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CustomButton(
                    text: '按鈕6',
                    width: 100,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          // 內容區域
          Expanded(
            child: ScrollableScaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 6),
                  CustomContainer(
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
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Detile');
                            },   
                          ),
                        ]
                      )
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 第二個訊息框
                  CustomContainer(
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
                          IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Detile');
                            },   
                          ),
                        ]
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
