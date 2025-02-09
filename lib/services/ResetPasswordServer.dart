import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ResetService {
  static String? token;
  static String? resettoken;
  //請求驗證碼
  static Future<void> requestPasswordReset(BuildContext context, String email) async{
    final url = Uri.parse("http://10.0.2.2:3000/resetpassword/request-reset");
    final response = await http.post(
      url,
      headers:{"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    
    final data = json.decode(response.body);
    print(data['message']);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message']))
    );
    
    if(response.statusCode == 200){
      token = data['token'];
      print('存取的token: ${token}');
      Navigator.pushNamed(context, '/Verification', arguments: email);//將email傳到下一頁，用於驗證頁面的重新傳送驗證碼
    }
  }

  //驗證碼檢驗
  static Future<void> verificationCode(BuildContext context, String code) async{
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("錯誤: 請先取得驗證碼"))
      );
      print("錯誤: 請先取得驗證碼");
      return;
    }
    print('及時驗證token: ${token}');

    final url = Uri.parse("http://10.0.2.2:3000/resetpassword/verify-code");
    final response = await http.post(
      url,
      headers:{"Content-Type": "application/json"},
      body: jsonEncode({"token": token, "code": code}),
    );

    final data = jsonDecode(response.body);
    print("驗證 API 回應: ${data['resettoken']}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message']))
    );

    if(response.statusCode == 200){
      resettoken = data['resettoken'];
      print("驗證成功！");
      Navigator.pushNamed(context, '/Resetpasswd');
    }else {
      print("錯誤: ${response.body}");
    }
  }

  
  static Future<void> ResetPassword(BuildContext context, String newpassword) async{
    print('newPassword: ${newpassword}');
    final url = Uri.parse("http://10.0.2.2:3000/resetpassword/reset-password");
    final response = await http.post(
      url,
      headers:{"Content-Type": "application/json"},
      body: jsonEncode({
        "resettoken": resettoken,
        "newpassword": newpassword,
      }),
    );

    final data = json.decode(response.body);
    if(response.statusCode == 200){
      print("密碼重設成功: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message']))
      );
      Navigator.pushNamed(context, '/');
    }else{
      print("密碼重設失敗: ${response.body}");
      if(data['success'] == false){
        showAlert(context);//重設密碼的token超時，會跳出視窗強制使用者返回/RequestRest
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message']))
      );
    }
  }
}
void showAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('操作已超時'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('返回前頁'),
            onPressed: () {
              Navigator.pushNamed(context, '/RequestRest');
            },
          ),
        ],
      );
    },
  );
}