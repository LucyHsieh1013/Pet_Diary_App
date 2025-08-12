import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/screens/app_page/Diary/message.dart';

class ChatPage extends StatefulWidget {
  @override
  ChatScreen createState() => ChatScreen();
}

class ChatScreen extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:3000/upload'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print('伺服器回應: $respStr');
    } else {
      print('上傳失敗，狀態碼: ${response.statusCode}');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: text, isUser: true));
        _messages.add(Message(text: "Got it!", isUser: false)); // 模擬回覆
      });
      _controller.clear();
      saveMessages();
      _scrollToBottom();
    }
  }

  Future<void> _sendImageMessage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = pickedFile;
      _messages.add(Message(text: '', imagePath: _image!.path, isUser: true));

      _messages.add(Message(text: '正在分析中...', isUser: false));
    });

    _scrollToBottom();

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:3000/upload'),
    );
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print('伺服器回應原始字串: $respStr');

      try {
        final jsonResponse = json.decode(respStr);
        final replyText = jsonResponse['generated_text']?.toString() ?? '無回覆';

        setState(() {
          _messages[_messages.length - 1] = Message(text: replyText, isUser: false);
        });

        saveMessages();
        _scrollToBottom();
      } catch (e) {
        print('JSON 解析錯誤: $e');
      }
    } else {
      print('上傳失敗，狀態碼: ${response.statusCode}');
    }
  }
}

  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = _messages.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList('chat_messages', messagesJson);
  }

  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('chat_messages') ?? [];
    setState(() {
      _messages.clear();
      _messages.addAll(messagesJson
          .map((msgStr) => Message.fromJson(jsonDecode(msgStr)))
          .toList());
    });
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final alignment = message.isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start;
                final bubbleColor =
                    message.isUser ? Colors.blue[300] : Colors.grey[300];
                final textColor =
                    message.isUser ? Colors.white : Colors.black87;

                return Column(
                  crossAxisAlignment: alignment,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: message.imagePath != null
                          ? Image.file(File(message.imagePath!))
                          : Text(
                              message.text,
                              style: TextStyle(color: textColor),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo, color: Colors.black),
                  onPressed: _sendImageMessage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write your message',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.black),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
