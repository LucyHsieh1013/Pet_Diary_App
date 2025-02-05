import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultTextField.dart';
import 'package:test_app/screens/component/PetImg.dart';
import 'package:test_app/screens/component/defaultButton.dart';
import 'package:test_app/screens/component/defaultContainer.dart';


class AddPetForm extends StatefulWidget {
  // const AddForm({super.key});

  @override
  State<AddPetForm> createState() => AddPetFormState();
}

class AddPetFormState extends State<AddPetForm> {
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      appBar: AppBar(
        title: Text(
          '新增寵物資訊',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            PetImage(imgUrl: '', Iconbutton: true,),//''填圖片路徑，預設為icon
            CustomTextField(hintText: '寵物名字', onChanged: (context){},),
            SizedBox(height: 20),
            CustomTextField(hintText: '品種', onChanged: (context){},),
            SizedBox(height: 20),
            CustomTextField(hintText: '性別', onChanged: (context){},),
            SizedBox(height: 20),
            CustomTextField(hintText: '生日', onChanged: (context){},),
            SizedBox(height: 20),
            CustomTextField(hintText: '迎接家庭的日期', onChanged: (context){},),
            SizedBox(height: 20),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                Navigator.pushNamed(context, '/Pet');
              },
            ),
          ],
        ),
      )
    );
  }
}