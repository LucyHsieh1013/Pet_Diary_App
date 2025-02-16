import 'package:flutter/material.dart';
import 'package:test_app/component/defaultTextField.dart';
import 'package:test_app/component/PetImg.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/services/AddPet.dart';
import 'package:intl/intl.dart'; 
class AddPetForm extends StatefulWidget {

  @override
  State<AddPetForm> createState() => AddPetFormState();
}

class AddPetFormState extends State<AddPetForm> {
  final imageUrl = null;//存放圖片路徑
  String name = '';
  String variety = '';
  String? gender;
  String birthday = '';
  TextEditingController _birthdayController = TextEditingController();

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
        _birthdayController.text = _formatDate(selectedDate);
      });
    }
  }
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('寵物名字'), // 標籤
                CustomTextField(
                  hintText: '請輸入寵物名字', 
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('品種'), // 標籤
                CustomTextField(
                  hintText: '品種', 
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('性別'), 
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
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('生日'),
                CustomTextField(
                  controller: _birthdayController,
                  hintText: '請選擇生日',
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {
                    setState(() {
                      birthday = value;
                    });
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      selectDate(context);                    
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                AddPet(context, name, variety, gender, birthday);
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