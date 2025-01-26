import 'package:flutter/material.dart';
import 'package:test_app/screens/login/LoginPage.dart';

import 'package:test_app/screens/login/RegisterPage.dart';
import 'package:test_app/screens/login/Forgetpasswd.dart';
import 'package:test_app/screens/login/VerificationPage.dart';
import 'package:test_app/screens/login/ResetPasswd.dart';

import 'package:test_app/screens/app_page/NavController.dart';
// import 'package:test_app/screens/app_page/appbar/SettingPage.dart';
import 'package:test_app/screens/app_page/component/AddPetForm.dart';
// import 'package:test_app/screens/app_page/pet/PetPage.dart';

void main() {
  runApp(MyApp());
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
        '/forgetpasswd': (context) => ForgetpasswdScreen(),//忘記密碼
        '/Verification': (context) => VerificationScreen(),//忘記密碼-驗證碼
        '/Resetpasswd': (context) => ResetpasswdScreen(),//忘記密碼-重設密碼
        // '/Setting': (context) => SettingPage(),//Appbar的設定
        '/Addform': (context) => AddPetForm(),
        // '/Pet': (context) => PetPage(),
      },
    );
  }
}


