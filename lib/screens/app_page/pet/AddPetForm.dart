import 'package:flutter/material.dart';
import 'package:test_app/component/defaultTextField.dart';
import 'package:test_app/component/circleImage.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/services/Form.dart';
import 'package:intl/intl.dart'; 
import 'package:test_app/provider/PetInformation.dart';
import 'package:provider/provider.dart';

import 'package:test_app/component/selectPicture.dart'; // 引入 ImagePickerWidget
import 'dart:io';

class AddPetForm extends StatefulWidget {
  @override
  State<AddPetForm> createState() => AddPetFormState();
}

class AddPetFormState extends State<AddPetForm> {
  File? _selectedImage;
  // 當選擇相片或拍照時，更新圖片
  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  bool isEditing = false;  // 用來儲存 isEditing 狀態
  final imageUrl = null;//存放圖片路徑
  String? gender;
  int? petid;
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _varietyController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 接收從路由傳遞過來的參數
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      isEditing = args['isEditing'] ?? false; // 設定 isEditing
    }
    if (isEditing) {
      PetProvider petProvider = Provider.of<PetProvider>(context, listen: false);
      petid = petProvider.id;
      _nameController.text = petProvider.name;
      _varietyController.text = petProvider.variety;
      if(gender == null){
        setState(() {
          gender = petProvider.gender;
        });
      }
      if(_birthdayController.text == ""){
        setState(() {
          _birthdayController.text = petProvider.birthday; // 預設生日
        });
      }
    }
  }

  // 格式化日期为 yyyy-MM-dd 格式
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // 显示日期选择器
  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // 将选择的日期格式化并显示在输入框中
      setState(() {
        // _birthdayController.text = _formatDate(selectedDate);
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? '編輯寵物資訊' : '新增寵物資訊',
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
            circleImage(
              imgUrl:'',
              piciconColor: Theme.of(context).colorScheme.secondary,
              // picIconbutton: true,
            ),
            ImagePickerWidget(onImageSelected: _onImageSelected),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  _selectedImage!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('寵物名字', style: Theme.of(context).textTheme.bodyLarge), // 標籤
                CustomTextField(
                  hintText: '請輸入寵物名字', 
                  controller: _nameController,
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('品種', style: Theme.of(context).textTheme.bodyLarge), // 標籤
                CustomTextField(
                  hintText: '品種', 
                  controller: _varietyController,
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('性別', style: Theme.of(context).textTheme.bodyLarge), 
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1), // 設定邊框顏色和寬度
                    borderRadius: BorderRadius.circular(5), // 圓角
                  ),
                  child: DropdownButtonHideUnderline( // 隱藏底線
                  child: DropdownButton<String>(
                    value: gender,
                    isExpanded: true, // 讓選單填滿
                    hint: Text('請選擇'),
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(value: '公', child: Text('公')),
                      DropdownMenuItem(value: '母', child: Text('母')),
                    ],
                  ),
                ),
              )]
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('生日', style: Theme.of(context).textTheme.bodyLarge),
                CustomTextField(
                  controller: _birthdayController,
                  hintText: '請選擇生日',
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {},
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.primary,),
                    onPressed: () {
                      selectDate(context);                    
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                print('petid: ${petid}');
                Petform(
                  context,
                  isEditing ? '/updatepet' : '/addpet',
                  _nameController.text, // 直接從 Controller 取值
                  _varietyController.text,
                  gender,
                  _birthdayController.text,
                  petid,
                );
              },
            ),
          ],
        ),
      )
    );
  }
}