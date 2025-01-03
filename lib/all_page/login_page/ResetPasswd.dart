import 'package:flutter/material.dart';

class ResetpasswdScreen extends StatefulWidget {
  @override
  Resetpasswd createState() => Resetpasswd();
}

class Resetpasswd extends State<ResetpasswdScreen> {
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
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                    print('按下按鈕');
                  },
                  child: Text(
                    '確定',
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