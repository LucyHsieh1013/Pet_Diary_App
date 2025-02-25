import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/component/defaultButton.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPage createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 按鈕區域
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // 左右加 16 的間距
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: '日',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 6), // 按鈕之間間距
                Expanded(
                  child: CustomButton(
                    text: '月',
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: CustomButton(
                    text: '年',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        // 內容區域
        
        Expanded(
          child: ScrollableScaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: Theme.of(context).colorScheme.primary, 
                      ),
                      SizedBox(width: 8),
                      Text("數值", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  // 折線圖 (Line Chart)
                  Container(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        minY: 0,
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: 1, // Y 軸格線間隔 1
                          verticalInterval: 1,
                        ), // 顯示網格
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true, // 顯示 Y 軸標籤
                              interval: 1, // Y 軸標籤的間距
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text(
                                    value.toInt().toString(),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                List<String> weekDays = [
                                  "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"
                                ];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    weekDays[value.toInt()],
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                          ),
                        ), // 顯示座標軸標籤
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            left: BorderSide(color: Theme.of(context).colorScheme.primary), // 只保留 Y 軸的邊框
                            top: BorderSide.none,
                            right: BorderSide.none,
                            bottom: BorderSide(color: Theme.of(context).colorScheme.primary), // 隱藏 X 軸的線
                          ),
                        ), // 顯示邊框
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 1), // (X, Y) 座標點
                              FlSpot(1, 3),
                              FlSpot(2, 2),
                              FlSpot(3, 1.5),
                              FlSpot(4, 4),
                              FlSpot(5, 3.5),
                            ],
                            isCurved: true, // 曲線平滑
                            color: Theme.of(context).colorScheme.primary, // 線條顏色
                            barWidth: 4, // 線條寬度
                            isStrokeCapRound: true, // 圓角線條
                            belowBarData: BarAreaData(show: false), // 隱藏下方區域
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40), // 間隔

                  // 圓餅圖 (Pie Chart)
                  Container(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: _chartSections(), // 設定數據
                        sectionsSpace: 2, // 區塊間距
                        centerSpaceRadius: 50, // 中心空白區域
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ]
    );
  }

  // 圓餅圖的數據
  List<PieChartSectionData> _chartSections() {
    return [
      PieChartSectionData(
        color: Color.fromARGB(255, 191, 117, 117),
        value: 40,
        title: '40%',
        radius: 50, // 圓餅塊的大小
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 147, 193, 119),
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 222, 200, 123),
        value: 20,
        title: '20%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 146, 178, 231),
        value: 10,
        title: '10%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}
