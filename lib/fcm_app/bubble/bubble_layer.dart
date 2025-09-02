import 'package:flutter/material.dart';
import 'bubble_manager.dart';
import 'bubble_scope.dart';
import 'package:dna/fcm_app/screen/chatScreen.dart';
import 'package:dna/main.dart'; // import navigatorKey

class GlobalBubbleLayer extends StatelessWidget {
  const GlobalBubbleLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = BubbleScope.of(context);
    return AnimatedBuilder(
      animation: manager,
      builder: (_, __) {
        return Stack(
          children: manager.bubbles.map((b) {
            return Positioned(
              left: b.position.dx,
              top: b.position.dy,
              child: Draggable(
                feedback: _bubble(b),
                childWhenDragging: const SizedBox.shrink(),
                onDraggableCanceled: (velocity, offset) {
                  final size = MediaQuery.of(context).size;
                  final safeX = offset.dx.clamp(0.0, size.width - 50);
                  final safeY = offset.dy.clamp(0.0, size.height - 50);
                  manager.updatePosition(
                      b.conversation.sender, Offset(safeX, safeY));
                },
                child: GestureDetector(
                  onTap: () {
                    // Reset số tin nhắn chưa đọc khi mở chat
                    b.conversation.unreadCount = 0;

                    manager.removeBubble(b.conversation.sender);
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          conversation: b.conversation,
                          onCollapse: () => manager.addBubble(b.conversation),
                        ),
                      ),
                    );
                  },
                  onLongPress: () {
                    manager.removeBubble(b.conversation.sender);
                  },
                  child: _bubble(b),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _bubble(CollapsedChatBubble bubble) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue,
          child: Text(
            bubble.conversation.sender[0].toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),

        // Badge đỏ hiển thị số chưa đọc
        if (bubble.conversation.unreadCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  bubble.conversation.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}


