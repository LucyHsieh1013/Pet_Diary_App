import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_app/services/Token.dart';

class PetProvider extends ChangeNotifier{
  bool? _haspet;

  bool? get haspet => _haspet;
  
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
        notifyListeners();
      }
    } catch(e){
      print('Error: $e');
      notifyListeners();
    }
  }
}