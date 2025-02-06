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
  final imageUrl = null;//存放圖片路徑

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
            // CircleAvatar(
            //   radius: 40,
            //   backgroundColor: Theme.of(context).primaryColor,
            //   backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
            //     ? NetworkImage(imageUrl!) // 只有當 `imageUrl` 存在時才載入圖片
            //     : null, // 否則不顯示圖片
            //   child: (imageUrl == null || imageUrl!.isEmpty)
            //     ? Icon(Icons.pets, color: Colors.white) // 預設圖示
            //     : null,
            // ),
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