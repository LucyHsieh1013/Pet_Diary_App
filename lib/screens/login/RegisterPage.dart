import 'package:flutter/material.dart';
import 'package:test_app/services/Validate.dart';
import 'package:test_app/component/defaultTextField.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/services/AuthServer.dart'; 

class RegisterScreen extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterScreen> {
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),  

          //註冊帳號表單
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    '註冊帳號',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '註冊一個新帳號',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: '使用者名稱',
                  onChanged: (value){
                    setState(() {
                      username = value; // 對話框內容
                      usernameError = Validate.validateUsername(value); // 及時驗證
                    });
                  },
                  validator: (value) => Validate.validateUsername(value), // formkey驗證
                  haveborder: true,
                  errorText: usernameError, //錯誤訊息顯示
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: 'example@gmail.com',
                  onChanged: (value){
                    setState(() {
                      email = value;
                      emailError = Validate.validateEmail(value);//及時驗證
                    });
                  },
                  validator: (value) => Validate.validateEmail(value),
                  haveborder: true,
                  errorText: emailError,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hintText: '6~8位數密碼',
                  obscureText: _obscureText,
                  onChanged: (value){
                    setState(() {
                      password = value;
                      passwordError = Validate.validatePassword(value);//及時驗證
                    });
                  },
                  validator: (value) => Validate.validatePassword(value),//formkey驗證需在validator裡
                  haveborder: true,
                  errorText: passwordError,
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
                CustomTextField(
                  hintText: '6~8位數密碼',
                  obscureText: _obscureText,
                  onChanged: (value){
                    setState(() {
                      confirmPassword = value;
                    });
                  },
                  validator: (value) => Validate.confirmPassword(password,value),
                  haveborder: true,
                  errorText: confirmPasswordError,
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
                    Container(
                      child: Text('已有帳號? '),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '前往登入',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 30, 84, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 10),
                CustomButton(
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  text: '註冊',
                  onPressed: () {
                    if(formkey.currentState!.validate()){
                      AuthService.RigisterSubmit(context, username,email, password, confirmPassword);
                    }
                  },
                ),
              ]
            ),
          ) 
          
        )
      )
    );
  }
}