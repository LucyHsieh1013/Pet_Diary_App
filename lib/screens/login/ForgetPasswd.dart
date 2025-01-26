import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ForgetpasswdScreen extends StatefulWidget {
  @override
  Forgetpasswd createState() => Forgetpasswd();
}

class Forgetpasswd extends State<ForgetpasswdScreen> {
  final TextEditingController emailController = TextEditingController();

  Future<void> requestPasswordReset(String email) async{
    final url = Uri.parse("http://10.0.2.2:3000/resetpassword/request-reset");
    final response = await http.post(
      url,
      headers:{"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    if(response.statusCode == 200){
      print("重設密碼連結已發送: ${response.body}");
    }else{
      print("請求失敗: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  '重設密碼',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '輸入您的Email',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 213, 213, 213)
                    ),
                    shadowColor: Colors.grey
                  ),
                  onPressed: () async{
                    final email = emailController.text.trim();
                    await requestPasswordReset(email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("重設密碼聯結將發送至您的信箱"))
                    );
                  },
                  child: Text(
                    '送出',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}