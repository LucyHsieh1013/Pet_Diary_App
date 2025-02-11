import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:test_app/provider/PetInformation.dart';

import 'package:test_app/screens/login/LoginPage.dart';

import 'package:test_app/screens/login/RegisterPage.dart';
import 'package:test_app/screens/login/RequestRest.dart';
import 'package:test_app/screens/login/VerificationPage.dart';
import 'package:test_app/screens/login/ResetPasswd.dart';

import 'package:test_app/screens/app_page/NavController.dart';
import 'package:test_app/screens/app_page/pet/AddPetForm.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PetProvider()),
      ],
      child: MyApp(),
    )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),//登入
        '/home': (context) => NavController(),//導覽列(管理五個主要畫面)
        '/register': (context) => RegisterScreen(),//註冊
        '/RequestRest': (context) => RequestRestScreen(),//忘記密碼
        '/Verification': (context) => VerificationScreen(),//忘記密碼-驗證碼
        '/Resetpasswd': (context) => ResetpasswdScreen(),//忘記密碼-重設密碼
        '/Addform': (context) => AddPetForm(),
      },

      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 232, 176, 124),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 232, 176, 124), // 主要顏色
          secondary: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 232, 176, 124),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black), // 主要文字樣式
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), // 標題
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 232, 176, 124), // 按鈕背景顏色
            foregroundColor: Colors.white, // 按鈕文字顏色
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 圓角按鈕
          ),
        ),
      ),
    );
  }
}


