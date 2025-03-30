import 'package:flutter/material.dart';
import 'package:test_app/component/defaultSheet.dart';
// import 'package:test_app/screens/app_page/Diary/AddRecord.dart';

void RecordSheet(BuildContext context){
  showCustomDialog(
    context,
    "新增",
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.sentiment_satisfied, color: Theme.of(context).colorScheme.primary),
          title: Text('情緒辨識',style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.monetization_on, color: Theme.of(context).colorScheme.primary),
          title: Text('支出', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //每日記錄頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.water_drop, color: Theme.of(context).colorScheme.primary),
          title: Text('飲水量', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            // Navigator.of(context, rootNavigator: true).pushNamed('/Addrecord');
            // Navigator.pushNamed(context, '/Addrecord');
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.fitness_center, color: Theme.of(context).colorScheme.primary),
          title: Text('體重', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.device_thermostat, color: Theme.of(context).colorScheme.primary),
          title: Text('體溫', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.local_dining, color: Theme.of(context).colorScheme.primary),
          title: Text('餵食', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.wc, color: Theme.of(context).colorScheme.primary),
          title: Text('廁所', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.medication, color: Theme.of(context).colorScheme.primary),
          title: Text('藥物', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        Divider(color: Theme.of(context).colorScheme.primary,),
        ListTile(
          leading: Icon(Icons.directions_walk, color: Theme.of(context).colorScheme.primary),
          title: Text('散步', style: Theme.of(context).textTheme.bodyLarge),
          onTap: (){
            //日記頁面
          },
        ),
        // SizedBox(height: 10),
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     onPressed: (){
        //       Navigator.pop(context);
        //       FloatbtnFirst(context);
        //     }, 
        //     style: ElevatedButton.styleFrom(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       side: BorderSide(
        //         color: const Color.fromARGB(255, 195, 195, 195),
        //       ),
        //       shadowColor: Colors.grey,
        //     ),
        //     child: Text(
        //       '取消',
        //       style: TextStyle(
        //         color: Colors.black,
        //       ),  
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
// import 'package:flutter/material.dart';

// class RecordSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("新增記錄")),
//       body: ListView(
//         padding: EdgeInsets.all(10),
//         children: [
//           _buildListTile(Icons.emoji_emotions, '情緒辨識'),
//           _buildListTile(Icons.attach_money, '支出'),
//           _buildListTile(Icons.local_drink, '飲水量'),
//           _buildListTile(Icons.fitness_center, '體重'),
//           _buildListTile(Icons.thermostat, '體溫'),
//           _buildListTile(Icons.restaurant, '餵食'),
//           _buildListTile(Icons.bed, '廁所'),
//         ],
//       ),
//     );
//   }

//   Widget _buildListTile(IconData icon, String title) {
//     return Card(
//       elevation: 2,
//       margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.blueGrey),
//         title: Text(title, style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
//         onTap: () {
//           // 點擊事件，例如開啟對應的輸入表單
//         },
//       ),
//     );
//   }
// }
