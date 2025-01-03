import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  @override
  Verification createState() => Verification();
}

class Verification extends State<VerificationScreen> {
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
                  '驗證',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '輸入您的驗證碼',
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
                    hintText: '六位數驗證碼',
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
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Resetpasswd');
                    print('按下按鈕');
                  },
                  child: Text(
                    '驗證',
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