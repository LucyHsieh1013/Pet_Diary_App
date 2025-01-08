import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/app_page/component/PetImg.dart';
import 'package:test_app/screens/component/defaultButton.dart';

class AddForm extends StatefulWidget {
  // const AddForm({super.key});

  @override
  State<AddForm> createState() => AddFormState();
}

class AddFormState extends State<AddForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新增寵物資訊',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            PetImage(imgUrl: '', Iconbutton: true,),//''填圖片路徑，預設為icon
            CustomTextField(hintText: '寵物名字'),
            SizedBox(height: 20),
            CustomTextField(hintText: '品種'),
            SizedBox(height: 20),
            CustomTextField(hintText: '性別'),
            SizedBox(height: 20),
            CustomTextField(hintText: '生日'),
            SizedBox(height: 20),
            CustomTextField(hintText: '迎接家庭的日期'),
            SizedBox(height: 20),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                // Navigator.pushNamed(context, '/Addform');
              },
            ),
          ],
        ),
      ),
    );
  }
}