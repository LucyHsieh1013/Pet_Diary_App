import 'package:flutter/material.dart';
import 'package:test_app/component/defaultTextField.dart';
import 'package:test_app/component/PetImg.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/services/AddPet.dart';

class AddPetForm extends StatefulWidget {

  @override
  State<AddPetForm> createState() => AddPetFormState();
}

class AddPetFormState extends State<AddPetForm> {
  final imageUrl = null;//存放圖片路徑
  String name = '';
  String variety = '';
  String gender = '';
  String birthday = '';
  String date = '';

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
            PetImage(imgUrl:'',),
            CustomTextField(
              hintText: '寵物名字', 
              onChanged: (value){
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: '品種', 
              onChanged: (value){
                setState(() {
                  variety = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: '性別', 
              onChanged: (value){
                setState(() {
                  gender = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: '生日', 
              onChanged: (value){
                setState(() {
                  birthday = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: '迎接家庭的日期', 
              onChanged: (value){
                setState(() {
                  date = value;
                });
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                AddPet(context, name, variety, gender, birthday, date);
                print('送出表單');
                print(name);
              },
            ),
          ],
        ),
      )
    );
  }
}