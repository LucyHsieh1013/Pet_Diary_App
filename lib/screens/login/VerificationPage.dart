import 'package:flutter/material.dart';
import 'package:test_app/screens/login/ResetPasswordServer.dart';
import 'dart:async'; // Timer
class VerificationScreen extends StatefulWidget {
  @override
  Verification createState() => Verification();
}
class Verification extends State<VerificationScreen> {
  final TextEditingController verifyController = TextEditingController();
  int count = 60;
  Timer? timer;

  //驗證碼倒數計時
  @override
  void initState(){
    super.initState();
    startCount();
  }
  void startCount(){
    timer?.cancel();
    setState(() {// 重設倒數時間
      count = 60;
    });
    timer = Timer.periodic(Duration(seconds: 1), (Timer t){
      if(count > 0){
        setState(() {
          count--;
        });
      }else{
        t.cancel();
      }
    });
  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;// 接收前一'/RequestRest'傳遞的email
    // print('傳遞email: ${email}');
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
                  controller: verifyController,
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
              //按鈕
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 213, 213, 213)
                        ),
                        shadowColor: Colors.grey
                      ),
                      onPressed: count > 0  
                        ?() {
                          final code = verifyController.text.trim();
                          ResetService.verificationCode(context, code);
                        }
                        : null,
                      child: Text(
                        count > 0  ? '驗證' : '驗證碼已過期',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 213, 213, 213)
                        ),
                        shadowColor: Colors.grey
                      ),
                      onPressed: () {
                        ResetService.requestPasswordReset(context, email);
                      },
                      child: Text('重新傳送驗證碼'),
                    ),
                  ),
                ]
              ),
              
              SizedBox(height: 10),
              //倒數
              Text(
                '剩餘時間: ${count.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: count > 0 ? Colors.black : Colors.red,
                  fontSize: 16,
                ),
              ),

            ]
          ),
        )
      )
    );
  }
}