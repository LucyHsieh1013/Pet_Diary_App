import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:test_app/screens/login/LoginServer.dart'; 
class LoginScreen extends StatefulWidget {
  @override
  LodinPage createState() => LodinPage();
}
class LodinPage extends State<LoginScreen> {
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();

  //使用者輸入帳密
  String  email = '';
  String  password = '';

  //帳密的錯誤訊息
  String? emailError;
  String? passwordError;

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
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'example@gmail.com',
                          onChanged: (value){
                            setState(() {
                              email = value;
                              emailError = Validate.validateEmail(value);//及時驗證
                            });
                          },
                          //因測試用的帳號不符格式，因此帳號的表單送出驗證暫時註解
                          // validator: (value) => Validate.validateEmail(value),
                          haveborder: true,
                          errorText: emailError,
                        ),
                        SizedBox(height: 10),
                        
                        //密碼輸入框
                        CustomTextField(
                          hintText: '6~8位數密碼',
                          obscureText: _obscureText,//切換密碼可視性
                          onChanged: (value){
                            setState(() {
                              password = value;
                              passwordError = Validate.validatePassword(value);//及時驗證
                            });
                          },
                          validator: (value) => Validate.validatePassword(value),//formkey驗證需在validator裡
                          haveborder: true,
                          errorText: passwordError,//即時驗證之錯誤訊息顯示於輸入框下方
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
                        SizedBox(height: 10),
                        //登入按鈕
                        CustomButton(
                          text: '登入',
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              AuthService.loginform(context, email, password);
                            }
                          },
                        ),
                      ],
                    )
                  ),
                  
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
                          Navigator.pushNamed(context, '/RequestRest');
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

                  //分隔線
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