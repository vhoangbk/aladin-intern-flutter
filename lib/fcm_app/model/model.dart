// Cac thong tin ve tin nhan

import 'message.dart';

class Conversation {
  final String sender;
  String lastMessage;
  DateTime time;
  List<Message> messages;
  int unreadCount;

  Conversation({
    required this.sender,
    required this.lastMessage,
    required this.time,
    required this.messages,
    this.unreadCount = 0,
  });

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'lastMessage': lastMessage,
        'time': time.toIso8601String(),
        'messages': messages.map((m) => m.toJson()).toList(),
        'unreadCount': unreadCount,
      };

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      sender: json['sender'],
      lastMessage: json['lastMessage'],
      time: DateTime.parse(json['time']),
      messages: (json['messages'] as List).map((m) {
        if (m is String) {
          // dữ liệu cũ: chỉ lưu text
          return Message(
            text: m,
            isMe: false,
            time: DateTime.now(),
          );
        } else {
          // dữ liệu mới: Map<String, dynamic>
          return Message.fromJson(Map<String, dynamic>.from(m));
        }
      }).toList(),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}

