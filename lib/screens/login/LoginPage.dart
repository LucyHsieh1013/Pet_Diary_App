import 'package:flutter/material.dart';
// import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';
// import 'package:test_app/screens/component/defaultContainer.dart';
// import 'package:test_app/screens/component/Validate.dart';
import 'package:test_app/screens/login/LoginForm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
class LoginScreen extends StatefulWidget {
  @override
  LodinPage createState() => LodinPage();
}
class LodinPage extends State<LoginScreen> {
  Future<void> connectToNode() async {
    try {
      // 使用適合模擬器的地址
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
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      '登入',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '歡迎使用，請登入您的帳號!',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //登入表單
                  LoginForm(),
                  
                  //註冊按鈕
                  CustomButton(
                    text: '註冊帳號',
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgetpasswd');
                        },
                        child: Text(
                          '忘記密碼?',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 30, 84, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 0.5,
                          child: Container(color: Colors.grey,),
                        )
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '或使用以下方式登入',
                          style: TextStyle(
                            color: Colors.grey,
                          )
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 0.5,
                          child: Container(color: Colors.grey,),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 3,
                          shadowColor: Colors.grey,
                          ),
                          child: Image.asset('assets/img/google.png', height: 30)
                        ),
                  
                      SizedBox(width: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 3,
                          shadowColor: Colors.grey,
                        ),
                        child: Image.asset('assets/img/facebook.png', height: 50)
                      ),
                    ]
                  ),
                ]
              ),
            )
          )
        ),
      ),
    );
    
  }
}