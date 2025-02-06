import 'package:flutter/material.dart';
import 'package:test_app/screens/login/ResetPasswordServer.dart';
import 'package:test_app/screens/component/defaultButton.dart';

class RequestRestScreen extends StatefulWidget {
  @override
  RequestRest createState() => RequestRest();
}
class RequestRest extends State<RequestRestScreen> {
  final TextEditingController emailController = TextEditingController();

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
                  '輸入您的Email',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
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
              CustomButton(
                backgroundColor: Colors.white,
                textColor: Colors.black,
                text: '送出',
                onPressed: () async{
                  final email = emailController.text.trim();
                  ResetService.requestPasswordReset(context, email);
                },
              ),
              // SizedBox(
              //   width: 300,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       side: const BorderSide(
              //         color: Color.fromARGB(255, 213, 213, 213)
              //       ),
              //       shadowColor: Colors.grey
              //     ),
              //     onPressed: () async{
              //       final email = emailController.text.trim();
              //       ResetService.requestPasswordReset(context, email);
              //       // ScaffoldMessenger.of(context).showSnackBar(
              //       //   SnackBar(content: Text("重設密碼聯結將發送至您的信箱"))
              //       // );
              //     },
              //     child: Text(
              //       '送出',
              //       style: TextStyle(
              //         color: Colors.red,
              //       ),
              //     ),
                  
              //   ),
              // ),
            ]
          ),
        )
      )
    );
  }
}