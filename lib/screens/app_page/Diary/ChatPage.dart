import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:test_app/screens/app_page/Diary/message.dart';
import 'package:test_app/services/base_url.dart';

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

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(text: text, isUser: true));
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/upload'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': text}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final replyText = jsonResponse['response']?.toString() ?? '沒有回覆';

        setState(() {
          _messages.add(Message(text: replyText, isUser: false));
        });
      } else {
        setState(() {
          _messages.add(Message(text: '發生錯誤，請稍後再試。', isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(Message(text: '無法連線至伺服器。', isUser: false));
      });
    }

    saveMessages();
    _scrollToBottom();
  }

  Future<void> _sendImageMessage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      _image = pickedFile;
      _messages.add(
        Message(text: '', imagePath: pickedFile.path, isUser: true),
      );
      _messages.add(Message(text: '分析中，請稍候...', isUser: false));
    });

    _scrollToBottom();

    var uri = Uri.parse('$BASE_URL/upload');
    http.StreamedResponse response;

    try {
      var request = http.MultipartRequest('POST', uri);

      if (kIsWeb) {
        Uint8List fileBytes = await pickedFile.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            fileBytes,
            filename: pickedFile.name,
          ),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('image', pickedFile.path),
        );
      }

      response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final jsonResponse = json.decode(respStr);

        setState(() {
          _messages[_messages.length - 1] =
              Message(text: jsonResponse['response'] ?? '無回覆', isUser: false);
        });
      } else {
        setState(() {
          _messages[_messages.length - 1] =
              Message(text: '圖片上傳失敗。', isUser: false);
        });
      }
    } catch (e) {
      setState(() {
        _messages[_messages.length - 1] =
            Message(text: '無法上傳圖片。', isUser: false);
      });
    }

    saveMessages();
    _scrollToBottom();
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
      _messages.addAll(
        messagesJson
            .map((msgStr) => Message.fromJson(jsonDecode(msgStr)))
            .toList(),
      );
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
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.isUser;
                final alignment =
                    isUser ? Alignment.centerRight : Alignment.centerLeft;

                return Container(
                  alignment: alignment,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (message.imagePath != null &&
                          message.imagePath!.isNotEmpty &&
                          isUser)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: kIsWeb
                              ? Image.network(
                                  message.imagePath!,
                                  width: 200,
                                )
                              : Image.file(
                                  File(message.imagePath!),
                                  width: 200,
                                ),
                        ),
                      if (message.text.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(maxWidth: 300),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.blue[600]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: isUser
                                  ? const Radius.circular(16)
                                  : const Radius.circular(0),
                              bottomRight: isUser
                                  ? const Radius.circular(0)
                                  : const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _sendImageMessage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(hintText: "輸入訊息..."),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
