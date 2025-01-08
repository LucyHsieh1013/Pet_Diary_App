import 'package:flutter/material.dart';

class PetImage extends StatelessWidget {
  final String imgUrl;
  final bool Iconbutton;

  const PetImage({
    Key? key,
    required this.imgUrl,
    this.Iconbutton = false,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (Iconbutton)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
            ),
          imgUrl.isNotEmpty
            ?Image.network(
              imgUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
            :Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 232, 176, 124),
              ),
            ),
          if (Iconbutton)
            Positioned(
              bottom: 30, // 往下超出10個像素
              right: 30,  // 往右超出10個像素
              child: Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black, // 圖標顏色
              ),
            )
        ]
      )
    );
  }
}