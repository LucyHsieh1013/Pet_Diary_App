import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_app/services/Token.dart';
import 'package:test_app/services/provider.dart';//加載以及重置provider


void Petform(BuildContext context, String route, String name, String? variety, String? gender, String? birthday, [int? id]) async {
  String? token = await getToken();
  if (token == null) { return; }
  print('token: ${token}');

  final response = await http.post(
    headers: {'Content-Type': 'application/json'},
    Uri.parse('http://10.0.2.2:3000/form$route'),
    body: json.encode({
      'token': token,
      'id': id,
      'name': name,
      'variety': variety,
      'gender': gender,
      'birthday': birthday,
    }),
  );

  final data = json.decode(response.body);
  if (response.statusCode == 200) {
    print('資料已成功傳送');
    resetAllProviders(context);
    loadAllProviders(context);
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

void userform(BuildContext context, String username, String email) async {
  String? token = await getToken();
  if (token == null) { return; }
  print('token: ${token}');

  final response = await http.post(
    headers: {'Content-Type': 'application/json'},
    Uri.parse('http://10.0.2.2:3000/form/updateuser'),
    body: json.encode({
      'token': token,
      'username': username,
      'email': email,
    }),
  );

  final data = json.decode(response.body);
  if (response.statusCode == 200) {
    print('資料已成功傳送');
    resetAllProviders(context);
    loadAllProviders(context);
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
