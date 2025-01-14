import 'package:flutter/material.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterScreen> {
  bool _obscureText = true;
  String email = '';
  String password = '';
  String confirmPassword = '';

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void formSubmit(){
    validateEmail(email);
    validatePassword(password);
    validateConfirmPasswordOnSubmit();

    if(emailError == null && passwordError == null && confirmPasswordError == null){
      print('提交的資料: email=$email, password=$password');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('註冊成功'))
      );
      Navigator.pop(context);
    }else{
      print('error');
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
    );
  }
}