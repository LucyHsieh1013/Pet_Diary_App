import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final Function(File?) onImageSelected; // 回傳選擇的圖片

  ImagePickerWidget({Key? key, required this.onImageSelected}) : super(key: key);

  final ImagePicker _picker = ImagePicker(); // 定義 ImagePicker

  // 開啟相簿
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImageSelected(File(image.path)); // 直接回傳圖片
    }
  }

  // 拍照
  Future<void> _pickImageFromCamera(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      onImageSelected(File(image.path)); // 直接回傳圖片
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Icons 靠右
      children: [
        IconButton(
          icon: Icon(Icons.photo, color: Theme.of(context).colorScheme.primary),
          onPressed: () => _pickImageFromGallery(context), // 點擊開啟相簿
        ),
        IconButton(
          icon: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
          onPressed: () => _pickImageFromCamera(context), // 點擊開啟相機
        ),
      ],
    );
  }
}
