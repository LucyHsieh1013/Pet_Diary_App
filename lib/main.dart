import 'package:flutter/material.dart';
import 'package:test_app/screens/login/RegisterPage.dart';
import 'package:test_app/screens/login/LoginPage.dart';
import 'package:test_app/screens/login/Forgetpasswd.dart';
import 'package:test_app/screens/login/VerificationPage.dart';
import 'package:test_app/screens/login/ResetPasswd.dart';

import 'package:test_app/screens/app_page/NavController.dart';
import 'package:test_app/screens/app_page/appbar/SettingPage.dart';
import 'package:test_app/screens/app_page/component/AddPetForm.dart';
import 'package:test_app/screens/app_page/pet/PetPage.dart';


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
        '/Addform': (context) => AddPetForm(),
        '/Pet': (context) => PetPage(),

      },
    );
  }
}


