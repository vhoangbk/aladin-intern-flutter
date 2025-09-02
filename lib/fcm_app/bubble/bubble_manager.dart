// Quan ly bong bong chat

import 'package:flutter/material.dart';
import 'package:dna/fcm_app/model/model.dart';

class CollapsedChatBubble {
  final Conversation conversation;
  Offset position;
  CollapsedChatBubble({
    required this.conversation,
    this.position = const Offset(300, 600),
  });
}

class BubbleManager extends ChangeNotifier {
  final List<CollapsedChatBubble> _bubbles = [];
  List<CollapsedChatBubble> get bubbles => List.unmodifiable(_bubbles);

  void addBubble(Conversation c) {
    if (_bubbles.any((b) => b.conversation.sender == c.sender)) return;
    _bubbles.add(CollapsedChatBubble(conversation: c));
    notifyListeners();
  }

  void removeBubble(String sender) {
    _bubbles.removeWhere((b) => b.conversation.sender == sender);
    notifyListeners();
  }

  void updatePosition(String sender, Offset pos) {
    final idx = _bubbles.indexWhere((b) => b.conversation.sender == sender);
    if (idx != -1) {
      _bubbles[idx].position = pos;
      notifyListeners();
    }
  }
}
