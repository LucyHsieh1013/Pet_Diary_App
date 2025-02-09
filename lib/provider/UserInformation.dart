import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_app/services/Token.dart'; // 確保你已經正確導入 getToken

class UserProvider extends ChangeNotifier {
  // 預設值
  String _useremail = '無'; 
  String _username = '使用者';

  // 賦值
  String get useremail => _useremail;
  String get username => _username;

  // 重置
  void resetUser() {
    _useremail = '無';
    _username = '使用者';
    notifyListeners(); // 通知 UI 更新
  }

  UserProvider() {
    fetchUser(); 
  }

  Future<void> fetchUser() async {
    try {
      String? token = await getToken();

      if (token == null) {
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/login/user-profile'),
        headers: {'Authorization': 'Bearer $token'}
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _useremail = data['email'] ?? '無';
        _username = data['username'] ?? '使用者';
        notifyListeners();
      } else {
        _useremail = '無';
        _username = '使用者';
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      _useremail = '無';
      _username = '使用者';
      notifyListeners();
    }
  }

}
