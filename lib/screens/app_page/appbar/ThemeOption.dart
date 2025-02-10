import 'package:flutter/material.dart';
import 'package:test_app/component/theme_option.dart';

import 'package:test_app/component/defaultSheet.dart';
import 'package:test_app/component/Themes.dart';

class SettingModel extends ChangeNotifier {
  ThemeData _themeData = BlueGreyTheme;

  ThemeData get theme => _themeData;

  changeTheme(themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
void ThemeSheet(BuildContext context){
  showCustomDialog(
    context,
    "主題變更",
    Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            ThemeContainer(color: Colors.blue),
            ThemeContainer(color: Colors.blueGrey),
            ThemeContainer(color: Colors.brown),
          ]
        ),
      ],
    )
  );
}
