import 'package:flutter/material.dart';
import 'package:test_app/screens/login/ResetPasswordServer.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/defaultButton.dart';

class ResetpasswdScreen extends StatefulWidget {
  @override
  Resetpasswd createState() => Resetpasswd();
}
class Resetpasswd extends State<ResetpasswdScreen> {
  bool _obscureText = true;
  final formkey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  
  String password = '';
  String confirmPassword = '';

  String? passwordError;

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
              Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: passwordController,
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
                      // errorText: confirmPasswordError,
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
                    CustomButton(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      text: '確定',
                      onPressed: () {
                        print(password);
                        if (formkey.currentState!.validate()) {
                          ResetService.ResetPassword(context, password);
                        }
                      },
                    ),
                  ]
                )
              ),
            ]
          ),
        )
      )
    );
  }
}