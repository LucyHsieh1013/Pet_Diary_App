import 'package:flutter/material.dart';

class PetImage extends StatefulWidget {
  final String imgUrl;
  final bool Iconbutton;

  const PetImage({
    Key? key,
    required this.imgUrl,
    this.Iconbutton = false,
  }) : super(key: key); 

  _ProfileImageUploaderState createState() => _ProfileImageUploaderState();
}
class _ProfileImageUploaderState extends State<PetImage> {
  // File? _imageFile;

  // Future<void> _pickImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final imageUrl = null;
    return Center(
      child: Stack(
        children: [
          // CircleAvatar(
          //   radius: 50,
          //   backgroundColor: Colors.grey[300], // 預設背景
          //   backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
          //   child: _imageFile == null
          //       ? Icon(Icons.person, size: 50, color: Colors.white) // 預設圖示
          //       : null,
          // ),
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).primaryColor,
            backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!) // 只有當 `imageUrl` 存在時才載入圖片
              : null, // 否則不顯示圖片
            child: (imageUrl == null || imageUrl!.isEmpty)
              ? Icon(Icons.pets, color: Colors.white) // 預設圖示
              : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              // onTap: _pickImage,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.grey, // 上傳按鈕背景色
                ),
                padding: EdgeInsets.all(6),
                child: Icon(Icons.camera_alt, color: Colors.black, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}