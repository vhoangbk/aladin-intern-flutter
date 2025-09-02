// Man hinh nen khoi dong

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dna/fcm_app/screen/listChat.dart';
import 'package:dna/fcm_app/model/model.dart';
import 'package:dna/fcm_app/service/firebase.dart';


class SplashScreen extends StatefulWidget {
  final FirebaseController controller;
  const SplashScreen({super.key, required this.controller});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Sau 2 giây chuyển qua HomeScreen
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ValueListenableBuilder<List<Conversation>>(
            valueListenable: widget.controller.conversationsNotifier,
            builder: (context, conversations, _) {
              return HomeScreen(
                conversations: conversations,
                onMarkRead: (conv) async {
                  await widget.controller.markRead(conv);
                },
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Image(image: AssetImage('assets/images/logo_chat.png'), width: 120,)       
      ),
    );
  }
}
