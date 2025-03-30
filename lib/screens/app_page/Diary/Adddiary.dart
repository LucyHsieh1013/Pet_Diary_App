import 'package:flutter/material.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/selectPicture.dart'; // 引入 ImagePickerWidget
import 'dart:io';

class AddDiary extends StatefulWidget {
  @override
  AddDiaryScreen createState() => AddDiaryScreen();
}

class AddDiaryScreen extends State<AddDiary> {
  File? _selectedImage;

  // 當選擇相片或拍照時，更新圖片
  void _onImageSelected(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      appBar: AppBar(
        title: Text(
          '新增日記',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            height: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // 使用 ImagePickerWidget 來處理選擇圖片
            ImagePickerWidget(onImageSelected: _onImageSelected),

            // 顯示選擇的圖片（如果有）
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

            Container(
              padding: EdgeInsets.all(0),
              child: TextField(
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "請輸入內容...",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            CustomButton(
              text: '送出',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
