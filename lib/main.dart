import 'package:flutter/material.dart';
import 'package:test_app/all_page/app_page/NavController.dart';
import 'package:test_app/all_page/login_page/RegisterPage.dart';
import 'package:test_app/all_page/login_page/LoginPage.dart';
import 'package:test_app/all_page/login_page/Forgetpasswd.dart';
import 'package:test_app/all_page/login_page/VerificationPage.dart';
import 'package:test_app/all_page/login_page/ResetPasswd.dart';
import 'package:test_app/all_page/app_page/SettingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => NavController(),
        '/forgetpasswd': (context) => ForgetpasswdScreen(),
        '/Verification': (context) => VerificationScreen(),
        '/Resetpasswd': (context) => ResetpasswdScreen(),
        '/Setting': (context) => SettingPage(),
      },
    );
  }
}


