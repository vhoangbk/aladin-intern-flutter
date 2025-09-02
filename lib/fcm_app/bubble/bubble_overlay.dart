// Khi an vao bong bong de mo chat

import 'package:flutter/material.dart';
import 'package:dna/fcm_app/bubble/bubble_layer.dart';

class BubbleOverlay extends StatelessWidget {
   // cần navContext để mở ChatScreen
  const BubbleOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBubbleLayer();
  }
}
