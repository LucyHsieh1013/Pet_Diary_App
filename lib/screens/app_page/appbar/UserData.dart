import 'package:flutter/material.dart';
import 'package:test_app/component/defaultTextField.dart';
import 'package:test_app/component/circleImage.dart';
import 'package:test_app/component/defaultButton.dart';
import 'package:test_app/component/defaultContainer.dart';
import 'package:test_app/services/Form.dart';
import 'package:test_app/provider/UserInformation.dart';
import 'package:provider/provider.dart';

class UpdateUserData extends StatefulWidget {
  @override
  State<UpdateUserData> createState() => UpdateUserDataState();
}

class UpdateUserDataState extends State<UpdateUserData> {
  final imageUrl = null;//存放圖片路徑
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 接收從路由傳遞過來的參數
    UserProvider petProvider = Provider.of<UserProvider>(context, listen: false);
    _emailController.text = petProvider.useremail;
    _nameController.text = petProvider.username;
  }
  
  @override
  Widget build(BuildContext context) {
    return ScrollableScaffold(
      appBar: AppBar(
        title: Text(
          '個人資料修改',
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
              defaultIcon: Icons.person,
              // picIconbutton: true,
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 讓標籤對齊左側
              children: [
                Text('名稱', style: Theme.of(context).textTheme.bodyLarge), // 標籤
                CustomTextField(
                  hintText: '請輸入名稱', 
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
                Text('email', style: Theme.of(context).textTheme.bodyLarge), // 標籤
                CustomTextField(
                  hintText: '請輸入email', 
                  controller: _emailController,
                  haveborder: true,
                  borderRadiusValue: 10,
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomButton(
              text: '確定',
              width: 120,
              onPressed: () {
                print('使用者資料修改');
                userform(
                  context,
                  _nameController.text, // 直接從 Controller 取值
                  _emailController.text
                );
              },
            ),
          ],
        ),
      )
    );
  }
}