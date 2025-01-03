import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterPage createState() => RegisterPage();
}

class RegisterPage extends State<RegisterScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),        child: Column(
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
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '6~8位數密碼',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
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
                ),
              ),SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: '再次輸入密碼',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
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
                ),
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
                  onPressed: () {
                    // 處理按鈕事件
                    print('按下按鈕');
                  },
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