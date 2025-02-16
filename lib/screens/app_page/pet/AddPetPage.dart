import 'package:flutter/material.dart';
import 'package:test_app/component/defaultButton.dart';

class AddPetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, color: Colors.white, size: 50),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            text: '+註冊寵物',
            width: 120,
            onPressed: () {
              Navigator.pushNamed(context, '/Addform');
            },
          ),
        ],
      ),
    );
  }
}