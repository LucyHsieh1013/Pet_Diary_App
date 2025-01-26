import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
class ResetpasswdScreen extends StatefulWidget {
  // final String token;
  // ResetpasswdScreen({required this.token});

  @override
  Resetpasswd createState() => Resetpasswd();
}

class Resetpasswd extends State<ResetpasswdScreen> {
  bool _obscureText = true;
  // final TextEditingController passwordController = TextEditingController();


  // Future<void> ResetPassword(String token, String newPassword) async{
  //   final url = Uri.parse("http://10.0.2.2:3000/resetpassword/reset-password");
  //   final response = await http.post(
  //     url,
  //     headers:{"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "token": token,
  //       "newPassword": newPassword,
  //     }),
  //   );
  //   if(response.statusCode == 200){
  //     print("密碼重設成功: ${response.body}");
  //   }else{
  //     print("密碼重設失敗: ${response.body}");
  //   }
  // }
  
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
                  '輸入您的新密碼',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  // controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '6~8位數密碼',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  ),
                ),
              ),SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '再次輸入密碼',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
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
                    // final email = passwordController.text.trim();
                    // await ResetPassword(token, newpassword);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text("重設密碼聯結將發送至您的信箱"))
                    // );
                  },
                  child: Text(
                    '確定',
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