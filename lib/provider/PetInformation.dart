import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_app/services/Token.dart';

class PetProvider extends ChangeNotifier{
  bool? _haspet;
  String _name = '載入中...';
  String _variety = '載入中...';
  String _gender = '載入中...';
  String _birthday = '載入中...';

  bool? get haspet => _haspet;
  String get name => _name;
  String get variety => _variety;
  String get gender => _gender;
  String get birthday => _birthday;

  void reset() {
    _haspet = null;
    notifyListeners(); // 通知 UI 更新
  }
  
  PetProvider(){
    fetchPet();
  }

  Future<void> fetchPet() async {
    try{
      String? token = await getToken();

      if (token == null) {
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/login/pet-profile'),
        headers: {'Authorization': 'Bearer $token'}
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _haspet = data['haspet'];
        _name = data['result'][0]['name'];
        _variety = data['result'][0]['variety'];
        _gender = data['result'][0]['gender'];
        _birthday = data['result'][0]['birthday'];
        print('前端: ${data['result'][0]['name']}');
        notifyListeners();
      }
    } catch(e){
      print('Error: $e');
      notifyListeners();
    }
  }
}