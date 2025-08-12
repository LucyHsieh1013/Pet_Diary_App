import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:test_app/services/Token.dart';
import 'package:test_app/services/provider.dart'; //加載以及重置provider
import 'package:test_app/screens/app_page/NavController.dart';

class AuthService {
  static Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded) as Map<String, dynamic>;
  }

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

  static Future<void> loginform(
    BuildContext context,
    String email,
    String password,
  ) async {
    final progress = ProgressHUD.of(context);
    progress?.showWithText('Loading...');

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = json.decode(response.body);
      progress?.dismiss();

      if (response.statusCode == 200) {
        String token = data['token'];
        print('存取token: ${token}');
        await saveToken(token); //token存到本地端
        String? aftersavetoken = await getToken();
        print('存取後的token: ${aftersavetoken}');

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'])));

        loadAllProviders(context); //加載provider
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavController()),
        ); // 跳轉到主畫面
        // Navigator.pushNamed(context, '/home'); // 跳轉到主畫面
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'] ?? '登入失敗')));
      }
    } catch (e) {
      progress?.dismiss();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('發生錯誤: $e')));
    }
  }

  static Future<void> RigisterSubmit(
    BuildContext context,
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'])));
        Navigator.pushNamed(context, '/'); //跳轉到主畫面
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'] ?? '登入失敗')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('發生錯誤: $e')));
    }
  }

  // 在 AuthService 裡，class 之上或裡面宣告一個全域 static
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '458238917861-ebdk3v7bslch3u5bfo2olfh9g8vrf5cf.apps.googleusercontent.com',
  );

  // 2. 改这里：不要再 new GoogleSignIn()
  static Future<void> signInWithGoogle(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress?.showWithText('正在使用 Google 登入…');
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        progress?.dismiss();
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;
      if (idToken == null) throw Exception('無法取得 Google idToken');

      // **临时解析并打印 payload：**
      final payload = _parseJwt(idToken);
      debugPrint('▶ idToken payload: $payload');

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/auth/google'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'idToken': idToken}),
      );
      debugPrint('[/auth/google] status=${response.statusCode}');
      debugPrint('[/auth/google] body=${response.body}');

      if (response.statusCode != 200) {
        progress?.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google 登入失敗：伺服器 ${response.statusCode}')),
        );
        return;
      }

      Map<String, dynamic> data;
      try {
        data = json.decode(response.body);
      } catch (_) {
        progress?.dismiss();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('伺服器資料解析失敗')));
        return;
      }

      // 成功流程……
      String token = data['token'];
      await saveToken(token);
      loadAllProviders(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavController()),
      );
    } catch (e) {
      progress?.dismiss();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google 登入發生錯誤: $e')));
    }
  }
}
