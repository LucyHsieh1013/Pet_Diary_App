import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:test_app/services/Token.dart';
import 'package:test_app/services/provider.dart';//加載以及重置provider

class AuthService {
  static Future<void> connectToNode() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000'));
      if (response.statusCode == 200) {
        print('Response from Node.js: ${response.body}');
      } else {
        print('Failed to connect: ${response.statusCode}');
      }
    } catch (e) {
      print('Error connecting to Node.js: $e');
    }
  }

  static Future<void> loginform(BuildContext context, String email, String password) async {
    final progress = ProgressHUD.of(context);
    progress?.showWithText('Loading...');

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = json.decode(response.body);
      progress?.dismiss();

      if (response.statusCode == 200) {
        String token = data['token'];
        print('存取token: ${token}');
        await saveToken(token);//token存到本地端
        String? aftersavetoken = await getToken();
        print('存取後的token: ${aftersavetoken}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );

        loadAllProviders(context);//加載provider
        Navigator.pushNamed(context, '/home'); // 跳轉到主畫面
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? '登入失敗')),
        );
      }
    } catch (e) {
      progress?.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('發生錯誤: $e')),
      );
    }
  }

  static Future<void> RigisterSubmit(BuildContext context, String username, String email, String password, String confirmPassword) async{
    try{
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/register'),
        headers: {'Content-Type':'application/json'},
        body: json.encode({
          'username' : username,
          'email': email,
          'password':password,
        })
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = json.decode(response.body);

      if(response.statusCode == 200 ){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']))
        );
        Navigator.pushNamed(context, '/'); //跳轉到主畫面
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? '登入失敗'))
        );
      }
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('發生錯誤: $e')),
      );
    }
  }
}
