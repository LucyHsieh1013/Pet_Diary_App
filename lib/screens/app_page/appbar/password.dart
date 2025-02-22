import 'package:flutter/material.dart';
import 'package:test_app/screens/login/ResetPasswd.dart';
// import 'package:test_app/services/Token.dart';

void password(BuildContext context) async {
  // String? token = await getToken();
  showDialog(
    context: context,
    barrierDismissible: true, // 點擊外部可關閉
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // 圓角
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,  // 寬度
            maxHeight: MediaQuery.of(context).size.height * 0.6, // 高度
          ),
          child: Padding(
            padding: EdgeInsets.all(16), // 內邊距
            child: ResetpasswdScreen(), 
          ),
        ),
      );
    },
  );
}
