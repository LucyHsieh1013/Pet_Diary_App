import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart'; // CustomContainer在這裡定義

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}
class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //分類標題
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    '消息分類',
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 16 / 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/Explore',
                          arguments: '寵物診所', // 傳遞標題
                        );
                      },
                      child: CustomContainer(
                        alignment: Alignment.topLeft,
                        color: Color.fromARGB(255, 151, 106, 106),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('寵物診所', style: Theme.of(context).textTheme.bodyMedium)
                        )
                      ),
                    ),
                    GestureDetector( // 寵物社群
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/Explore',
                          arguments: '寵物社群', // 傳遞標題
                        );
                      },
                      child: CustomContainer(
                        alignment: Alignment.topLeft,
                        color: Color.fromARGB(255, 123, 151, 106),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('寵物社群', style: Theme.of(context).textTheme.bodyMedium)
                        )
                      ),
                    ),
                    GestureDetector( // 寵物友善
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/Explore',
                          arguments: '寵物友善', // 傳遞標題
                        );
                      },
                      child: CustomContainer(
                        alignment: Alignment.topLeft,
                        color: Color.fromARGB(255, 181, 166, 113),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('寵物友善', style: Theme.of(context).textTheme.bodyMedium)
                        )
                      ),
                    ),
                    GestureDetector( // 寵物商店
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/Explore',
                          arguments: '寵物商店', // 傳遞標題
                        );
                      },
                      child: CustomContainer(
                        alignment: Alignment.topLeft,
                        color: Color.fromARGB(255, 108, 115, 126),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('寵物商店', style: Theme.of(context).textTheme.bodyMedium)
                        )
                      ),
                    )
                    // Container(
                    //   padding: const EdgeInsets.all(10), 
                    //   decoration: const BoxDecoration(
                    //     color: Color.fromARGB(255, 170, 119, 119),
                    //     borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       image: DecorationImage(
                    //         image: AssetImage("assets/img/PetHospital.jpg"), // 請確保圖片存在 assets 資料夾
                    //         fit: BoxFit.cover,
                    //       ),
                    //   ),
                    //   child: Text('寵物診所'),
                    // ),
                  ],
                ),
                //橫向卷軸標題
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    '最新消息',
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                ),
                //跳轉連結
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Text(
                    '檢視',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    )
                  ),
                ),
                //子物件
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,//橫向滑動
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomContainer(
                              width: 100,
                              height: 100,
                              color: Color.fromARGB(255, 223, 223, 223),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '消息',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                    ],
                  )
                )
              ],
            )
          )
        ],
      ),
    );
  }
}