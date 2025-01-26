import 'package:flutter/material.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterScreen> {
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  Future<void> formSubmit() async{
    if(formkey.currentState!.validate()){
      try{
        final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/register'),
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
          Navigator.pushNamed(context, '/'); //跳轉到主畫面
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
  void validateConfirmPasswordOnSubmit() {
    setState(() {
      confirmPasswordError = Validate.confirmPassword(password, confirmPassword);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),  
          
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
                  hintText: 'example@gmail.com',
                  onChanged: (value){
                    setState(() {
                      email = value;
                      validateEmail(value);
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
                      validatePassword(value);
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
                  text: '註冊',
                  onPressed: formSubmit,
                ),
              ]
            ),
          ) 
          
        )
      )
    );
  }
}

  // void formSubmit(){
  //   // validateEmail(email);
  //   // validatePassword(password);
  //   validateConfirmPasswordOnSubmit();

  //   if(emailError == null && passwordError == null && confirmPasswordError == null){
  //     print('提交的資料: email=$email, password=$password');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('註冊成功，可進行登入'))
  //     );
  //     Navigator.pop(context);
  //   }else{
  //     print('error');
  //   }
  // }