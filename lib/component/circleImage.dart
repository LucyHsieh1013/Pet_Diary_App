import 'package:flutter/material.dart';

class circleImage extends StatefulWidget {
  final String imgUrl;
  final bool Iconbutton;
  final Color? iconColor;
  final Color? piciconColor;
  final bool picIconbutton;
  final Color? backgroundColor;
  final IconData defaultIcon;

  const circleImage({
    Key? key,
    required this.imgUrl,
    this.Iconbutton = false,
    this.backgroundColor,
    this.iconColor,
    this.piciconColor,
    this.picIconbutton = false,
    this.defaultIcon = Icons.pets,
  }) : super(key: key); 

  _ProfileImageUploaderState createState() => _ProfileImageUploaderState();
}
class _ProfileImageUploaderState extends State<circleImage> {
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
            backgroundColor: widget.backgroundColor,
            backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!) // 只有當 `imageUrl` 存在時才載入圖片
              : null, // 否則不顯示圖片
            child: (imageUrl == null || imageUrl!.isEmpty)
              ? Icon(widget.defaultIcon, color: widget.iconColor) // 預設圖示
              : null,
          ),
          if (widget.picIconbutton)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  print("開啟圖片選擇");
                  // 這裡可以添加打開圖片選擇的功能
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.7), // 背景顏色
                  ),
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.camera_alt, color: widget.piciconColor ?? Colors.white, size: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}