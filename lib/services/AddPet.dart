import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/services/Token.dart';

void AddPet(BuildContext context, String name, String variety, String gender, String birthday, String date) async {
  String? token = await getToken();
  if (token == null) { return; }
  print('token: ${token}');
  final response = await http.post(
    headers: {'Content-Type': 'application/json'},
    Uri.parse('http://10.0.2.2:3000/form/addpet'),
    body: json.encode({
      'token': token,
      'name': name,
      'variety': variety,
      'gender': gender,
      'birthday': birthday,
      'date': date,
    }),
  );

  final data = json.decode(response.body);
  print('表單回傳: ${data}');
  if (response.statusCode == 200) {
    print('資料已成功傳送');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message']))
    );
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message']))
    );
    print('傳送資料失敗');
  }
}
