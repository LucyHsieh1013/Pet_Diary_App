import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:test_app/provider/PetInformation.dart';

import 'package:test_app/screens/login/LoginPage.dart';

import 'package:test_app/screens/login/RegisterPage.dart';
import 'package:test_app/screens/login/RequestRest.dart';
import 'package:test_app/screens/login/VerificationPage.dart';
import 'package:test_app/screens/login/ResetPasswd.dart';

import 'package:test_app/screens/app_page/Explore/Explorelist.dart';
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
        '/Explore': (context) => Explorelist(),
      },

      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: Colors.blueGrey, // 主要顏色
          secondary: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.blueGrey), // 主要文字樣式
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          titleLarge: TextStyle(fontSize: 22, color: Colors.blueGrey, fontWeight: FontWeight.bold), // 標題
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, // 按鈕背景顏色
            foregroundColor: Colors.white, // 按鈕文字顏色
          ),
        ),
      ),
    );
  }
}


