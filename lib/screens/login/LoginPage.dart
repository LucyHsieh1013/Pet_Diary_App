import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  LodinPage createState() => LodinPage();
}

class LodinPage extends State<LoginScreen> {
  bool _obscureText = true;

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

              //Email輸入框
              CustomTextField(
                hintText: 'example@gmail.com',
                haveborder: true,
              ),
              SizedBox(height: 10),
              
              //密碼輸入框
              CustomTextField(
                hintText: '6~8位數密碼',
                haveborder: true,
                obscureText: _obscureText,
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
              
              SizedBox(height: 10),
              //登入按鈕
              CustomButton(
                text: '登入',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              //註冊按鈕
              CustomButton(
                text: '註冊帳號',
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
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
    );
  }
}