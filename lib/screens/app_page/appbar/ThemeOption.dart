import 'package:flutter/material.dart';
import 'package:test_app/screens/component/theme_option.dart';
// import 'package:test_app/screens/app_page/component/theme_option.dart';

import 'package:test_app/screens/component/defaultSheet.dart';

void ThemeSheet(BuildContext context){
  showCustomDialog(
    context,
    "主題變更",
    Column(
      children: [
        Wrap(
          spacing: 8,
          children: [
            ThemeContainer(color: Colors.black),
            ThemeContainer(color: Colors.blue),
            ThemeContainer(color: Colors.blueGrey),
          ]
        ),
      ],
    )
  );
}
// class ThemeOption extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),// AppBar.dart
//       body: Container(
//         child: Column(
//           children: [
//             Text('主題修改', style: TextStyle(fontSize: 20),),
//             Wrap(
//               spacing: 8,
//               children: [
//                 ThemeContainer(color: Colors.black),
//                 ThemeContainer(color: Colors.blue),
//                 ThemeContainer(color: Colors.blueGrey),
//               ]
//             ),
//           ],
//         )
        
//       ) 
//     );
//   }
// }
