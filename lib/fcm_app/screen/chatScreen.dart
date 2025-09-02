// Ben trong doan chat

import 'package:flutter/material.dart';
import 'package:dna/fcm_app/model/model.dart';
import 'package:dna/fcm_app/model/message.dart';
import 'package:dna/fcm_app/bubble/bubble_scope.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  final VoidCallback onCollapse;

  const ChatScreen({
    super.key,
    required this.conversation,
    required this.onCollapse,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      widget.conversation.messages.add(
        Message(
          text: text,
          isMe: true,
          time: DateTime.now(),
        ),
      );
      widget.conversation.lastMessage = text;
      widget.conversation.time = DateTime.now();
    });
    _messageController.clear();

    // cuộn xuống cuối
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = _messageController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.conversation.sender),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {
              BubbleScope.of(context).addBubble(widget.conversation);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Danh sách tin nhắn
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: widget.conversation.messages.length,
                itemBuilder: (context, index) {
                  final msg = widget.conversation.messages[index];
                  final isMe = msg.isMe;
                  // Tạo vùng chat bên trái/phải
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft:
                              isMe ? const Radius.circular(12) : Radius.zero,
                          bottomRight:
                              isMe ? Radius.zero : const Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        msg.text,
                        style: TextStyle(
                          color: isMe 
                            ? Colors.white 
                            : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Thanh nhập tin nhắn
            SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions,
                          color: Colors.grey),
                      onPressed: () {},
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "GIF",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Ô nhập Aa
                    Expanded(
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: "Aa",
                            border: InputBorder.none,
                          ),
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Emoji
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: Colors.grey),
                      onPressed: () {},
                    ),

                    // Gửi hoặc Like
                    hasText
                        ? IconButton(
                            icon:
                                const Icon(Icons.send, color: Colors.blue),
                            onPressed: _sendMessage,
                          )
                        : IconButton(
                            icon: const Icon(Icons.thumb_up,
                                color: Colors.blue),
                            onPressed: () {},
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



