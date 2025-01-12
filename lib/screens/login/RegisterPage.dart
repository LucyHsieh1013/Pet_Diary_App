import 'package:flutter/material.dart';
import 'package:test_app/screens/component/Validate.dart';
import 'package:test_app/screens/component/defaultTextField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterScreen> {
  bool _obscureText = true;
  final Map<String, String> formData = {
    'email': '',
    'password': '',
    'confirmPassword': '',
  };
  String? emailError;
  String? passwordError;
  String? confirmPassword;

  void formSubmit(){
    final emailErr = Validate.validateEmail(formData['email']);
    final passwordErr = Validate.validatePassword(formData['password']);
    final confirmErr = Validate.confirmPassword(formData['password'],formData['confirmPassword']);

    setState(() {
      emailError = emailErr;
      passwordError = passwordErr;
      confirmPassword = confirmErr;
    });

    if(emailError == null && passwordError == null && confirmErr == null){
      print('提交的資料: $formData');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('註冊成功'))
      );
      Navigator.pop(context);
    }else{
      print('error');
    }
    
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
                    formData['email'] = value;
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
                    formData['password'] = value;
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
                    formData['confirmPassword'] = value;
                  });
                },
                haveborder: true,
                errorText: confirmPassword,
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
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 213, 213, 213)
                    ),
                    shadowColor: Colors.grey
                  ),
                  onPressed: formSubmit,
                  child: Text(
                    '註冊',
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