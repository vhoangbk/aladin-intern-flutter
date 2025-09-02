// tin nhan gui va nhan

class Message {
  final String text;
  final bool isMe; // true = tin nhắn mình gửi, false = tin nhắn người khác
  final DateTime time;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'isMe': isMe,
        'time': time.toIso8601String(),
      };

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      isMe: json['isMe'] ?? false,
      time: DateTime.parse(json['time']),
    );
  }
}
