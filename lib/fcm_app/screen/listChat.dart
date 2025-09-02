// Danh sach cac hoi thoai

import 'package:flutter/material.dart';
import 'package:dna/fcm_app/model/model.dart';
import 'package:dna/fcm_app/screen/chatScreen.dart';
import 'package:dna/fcm_app/bubble/bubble_scope.dart';

class HomeScreen extends StatefulWidget {
  final List<Conversation> conversations;
  final Function(Conversation) onMarkRead; // callback từ main.dart

  const HomeScreen({
    super.key,
    required this.conversations,
    required this.onMarkRead,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _collapse(Conversation conv) {
    BubbleScope.of(context).addBubble(conv);
  }

  @override
  Widget build(BuildContext context) {
    final keyword = _searchController.text.toLowerCase();

    final listToShow = keyword.isNotEmpty
        ? widget.conversations
            .where((conv) =>
                conv.sender.toLowerCase().contains(keyword) ||
                conv.lastMessage.toLowerCase().contains(keyword))
            .toList()
        : widget.conversations;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              // ô tìm kiếm
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm hội thoại...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // danh sách hội thoại
              Expanded(
                child: listToShow.isEmpty
                  ? const Center(child: Text("Không tìm thấy hội thoại nào"))
                  : ListView.builder(
                      itemCount: listToShow.length,
                      itemBuilder: (context, index) {
                        final conv = listToShow[index];
                        return ListTile(
                          leading: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(conv.sender[0].toUpperCase()),
                              ),
                              if (conv.unreadCount > 0)
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Text(
                                      conv.unreadCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                            conv.sender,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            conv.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            "${conv.time.hour}:${conv.time.minute.toString().padLeft(2, '0')}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            // ✅ Reset số chưa đọc ở main.dart
                            widget.onMarkRead(conv);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  conversation: conv,
                                  onCollapse: () => _collapse(conv),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      )
    );
  }
}





