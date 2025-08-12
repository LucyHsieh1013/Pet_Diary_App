class Message {
  final String text;
  final String? imagePath;
  final bool isUser;

  Message({required this.text, this.imagePath, required this.isUser});

  Map<String, dynamic> toJson() => {
        'text': text,
        'imagePath': imagePath,
        'isUser': isUser,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json['text'] ?? '',
        imagePath: json['imagePath'],
        isUser: json['isUser'] ?? false,
      );
}
