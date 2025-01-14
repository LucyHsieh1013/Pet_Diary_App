import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';
import 'package:test_app/screens/component/Validate.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final loginValidate = Validate();
  final formkey = GlobalKey<FormState>();

  String  email = '';
  String  password = '';
  String? emailError;
  String? passwordError;

  //提交表單
  void formSubmit(){
    validateEmail(email);
    validatePassword(password);

    print('提交的資料: $email, $password');
    if(formkey.currentState!.validate()){
      final error = loginValidate.login(email, password);
      if(error != null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('帳號密碼有誤'))
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登入成功'))
        );
        Navigator.pushNamed(context, '/home');
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
            haveborder: true,
            errorText: emailError,
          ),
          SizedBox(height: 10),
          
          //密碼輸入框
          CustomTextField(
            hintText: '6~8位數密碼',
            obscureText: _obscureText,
            onChanged: (value){
              setState(() {
                password = value;
              });
              validatePassword(value);
            },
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