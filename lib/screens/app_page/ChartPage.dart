import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class ChartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("圖表"),
//     );
//   }
// }
class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _TestState();
}

class _TestState extends State<ChartPage> {
  Future<List<Map<String, dynamic>>> fetchUser() async {
    try{
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/user'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response body: ${response.body}');
        print('success: ${data['success']}');

        if(data['success'] == true){
          return List<Map<String, dynamic>>.from(data['users'] ?? []);
        }
      }
    }catch(e){
      print('Error fetching users: $e');
    }
    return [];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用戶列表')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchUser(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('加載失敗'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('沒有用戶資料'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['email']),
                subtitle: Text(user['password']),
              );
            },
          );
        }
      ),
    );
  }
}