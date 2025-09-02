// Xu li FCM va luu tru cac cuoc hoi thoai

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:dna/fcm_app/model/model.dart';
import 'package:dna/fcm_app/model/message.dart';

class FirebaseController {
  final ValueNotifier<List<Conversation>> conversationsNotifier =
      ValueNotifier<List<Conversation>>([]);

  List<Conversation> _conversations = [];

  Future<void> init() async {
    await _loadConversations();
    _initFCM();
  }

  void _initFCM() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM Token: $token");

    FirebaseMessaging.onMessage.listen(_handleIncomingMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleIncomingMessage);
  }

  void _handleIncomingMessage(RemoteMessage message) async {
    final sender = message.notification?.title ?? "Người lạ";
    final body = message.notification?.body ?? "Không có nội dung";

    final msg = Message(
      text: body,
      isMe: false, // tin nhắn từ người khác
      time: DateTime.now(),
    );

    final index = _conversations.indexWhere((c) => c.sender == sender);
    if (index != -1) {
      _conversations[index].lastMessage = body;
      _conversations[index].time = DateTime.now();
      _conversations[index].messages.add(msg);
      _conversations[index].unreadCount += 1;

      final updated = _conversations.removeAt(index);
      _conversations.insert(0, updated);
    } else {
      _conversations.insert(
        0,
        Conversation(
          sender: sender,
          lastMessage: body,
          time: DateTime.now(),
          messages: [msg],
          unreadCount: 1,
        ),
      );
    }

    await _saveConversations();
    conversationsNotifier.value = List.from(_conversations);
  }

  Future<void> _loadConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('conversations');
    if (data != null) {
      final List decoded = jsonDecode(data);
      _conversations =
          decoded.map((e) => Conversation.fromJson(e)).toList();
      conversationsNotifier.value = List.from(_conversations);
    }
  }

  Future<void> _saveConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _conversations.map((c) => c.toJson()).toList();
    await prefs.setString('conversations', jsonEncode(data));
  }

  Future<void> markRead(Conversation conv) async {
    final index = _conversations.indexWhere((c) => c.sender == conv.sender);
    if (index != -1) {
      _conversations[index].unreadCount = 0;
      await _saveConversations();
      conversationsNotifier.value = List.from(_conversations);
    }
  }
}

