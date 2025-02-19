import 'package:flutter/material.dart';
import 'package:test_app/screens/app_page/ChartPage.dart';
import 'package:test_app/screens/app_page/Diary/DiaryPage.dart';
import 'package:test_app/screens/app_page/CalendarPage.dart';
import 'package:test_app/screens/app_page/ExplorePage.dart';
import 'package:test_app/screens/app_page/pet/AddPetPage.dart';
import 'package:test_app/screens/app_page/appbar/AppBar.dart';
import 'package:test_app/screens/app_page/appbar/SettingPage.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/PetInformation.dart';

import 'package:test_app/screens/app_page/pet/PetPage.dart';

class NavController extends StatefulWidget {
  @override
  _NavController createState() => _NavController();
}

class _NavController extends State<NavController> {
  int _currentIndex = 0; // 當前選中的頁面索引

  
  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);

    Widget petPage;
    if (petProvider.haspet == null) {
      petPage = Center(child: CircularProgressIndicator()); // 加載中
    } else {
      petPage = petProvider.haspet! ? PetPage() : AddPetPage();
    }

    final pages = [
      petPage,
      // AddPetPage(),// PetPage.dart
      // PetPage(),//註冊寵物以後的頁面
      ChartPage(), // ChartPage.dart
      DiaryPage(), // DiaryPage.dart
      CalendarPage(), // CalendarPage.dart
      ExplorePage(),// ExplorePage.dart
    ];
    return Scaffold(
      appBar: buildAppBar(context),// AppBar.dart
      endDrawer: SettingDrawer(context),
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
            icon: Icon(Icons.space_dashboard_rounded),
            label: '探索',
          ),
        ],
        type: BottomNavigationBarType.fixed, // 固定模式
        selectedItemColor: Theme.of(context).primaryColor, // 選中項目顏色
        unselectedItemColor: Colors.grey, // 未選中項目顏色
      ),
    );
  }
}