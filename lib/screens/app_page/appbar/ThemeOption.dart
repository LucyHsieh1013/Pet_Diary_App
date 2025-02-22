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

void ThemeSheet(BuildContext context) {
  showCustomDialog(
    context,
    "主題變更",
    (context, setState) {
      Color? selectedColor;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 0, // 物件間的水平間距
                  children: [
                    ThemeContainer(
                      color: Colors.blue,
                      isSelected: selectedColor == Colors.blue,
                      onTap: () {
                        setState(() => selectedColor = Colors.blue);
                      },
                    ),
                    ThemeContainer(
                      color: Colors.blueGrey,
                      isSelected: selectedColor == Colors.blueGrey,
                      onTap: () {
                        setState(() => selectedColor = Colors.blueGrey);
                      },
                    ),
                    ThemeContainer(
                      color: Colors.brown,
                      isSelected: selectedColor == Colors.brown,
                      onTap: () {
                        setState(() => selectedColor = Colors.brown);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


// void ThemeSheet(BuildContext context){
//   showCustomDialog(
//     context,
//     "主題變更",
//     Column(
//       children: [
//         Wrap(
//           spacing: 8,
//           children: [
//             ThemeContainer(color: Colors.blue),
//             ThemeContainer(color: Colors.blueGrey),
//             ThemeContainer(color: Colors.brown),
//           ]
//         ),
//       ],
//     )
//   );
// }