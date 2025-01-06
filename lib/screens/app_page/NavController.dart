import 'package:flutter/material.dart';
import 'package:test_app/all_page/app_page/ChartPage.dart';
import 'package:test_app/all_page/app_page/DiaryPage.dart';
import 'package:test_app/all_page/app_page/CalendarPage.dart';
import 'package:test_app/all_page/app_page/ExplorePage.dart';
import 'package:test_app/all_page/app_page/PetPage.dart';
import 'package:test_app/all_page/app_page/AppBar.dart';

class NavController extends StatefulWidget {
  @override
  _NavController createState() => _NavController();
}

class _NavController extends State<NavController> {
  int _currentIndex = 0; // 當前選中的頁面索引

  final pages = [
    PetPage(),// PetPage.dart
    ChartPage(), // ChartPage.dart
    DiaryPage(), // DiaryPage.dart
    CalendarPage(), // CalendarPage.dart
    ExplorePage(),// ExplorePage.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),// AppBar.dart
      body: pages[_currentIndex], // 根據當前索引顯示對應的頁面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 當前選中的索引
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 更新索引
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: '寵物',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '圖表',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '日記',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '日曆',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: '探索',
          ),
        ],
        type: BottomNavigationBarType.fixed, // 固定模式
        selectedItemColor: Colors.blue, // 選中項目顏色
        unselectedItemColor: Colors.grey, // 未選中項目顏色
      ),
    );
  }
}