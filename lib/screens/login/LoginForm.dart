import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  // final loginValidate = Validate();// Validate.dart
  final formkey = GlobalKey<FormState>();

  //使用者輸入帳密
  String  email = '';
  String  password = '';

  //帳密的錯誤訊息
  String? emailError;
  String? passwordError;

  //後端帳密驗證
  Future<void> formSubmit() async{
    if(formkey.currentState!.validate()){
      try{
        final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/login'),
          headers: {'Content-Type':'application/json'},
          body: json.encode({
            'email': email,
            'password':password,
          })
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        final data = json.decode(response.body);

        if(response.statusCode == 200 ){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message']))
          );
          Navigator.pushNamed(context, '/home'); //跳轉到主畫面
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? '登入失敗'))
          );
        }
      }catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('發生錯誤: $e')),
        );
      }
    }
  }
  //即時錯誤回報
  void validateEmail(String value) {
    setState(() {
      emailError = Validate.validateEmail(value);
    });
  }
  void validatePassword(String value) {
    setState(() {
      passwordError = Validate.validatePassword(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'example@gmail.com',
            onChanged: (value){
              setState(() {
                email = value;
              });
              validateEmail(value);
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
              });
              validatePassword(value);//即時驗證
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
            onPressed: formSubmit,
          ),
        ],
      )
      
    );
  }
}


  //提交表單
  // void formSubmit(){
  //   validateEmail(email);
  //   validatePassword(password);

  //   print('提交的資料: $email, $password');
  //   if(formkey.currentState!.validate()){
  //     final error = loginValidate.login(email, password);
  //     if(error != null){
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('帳號密碼有誤'))
  //       );
  //     }else{
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('登入成功'))
  //       );
  //       Navigator.pushNamed(context, '/home');
  //     }
  //   }
  // }