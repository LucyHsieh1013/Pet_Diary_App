import 'package:flutter/material.dart';

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
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text('登入'),
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    '註冊帳號',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  
                ),
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