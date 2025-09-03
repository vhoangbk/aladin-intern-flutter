import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dna/fcm_app/screen/splash_screen.dart';
import 'package:dna/fcm_app/service/firebase.dart';
// bubble
import 'package:dna/fcm_app/bubble/bubble_manager.dart';
import 'package:dna/fcm_app/bubble/bubble_scope.dart';
import 'package:dna/fcm_app/bubble/bubble_overlay.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("BG: ${message.notification?.title} - ${message.notification?.body}");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BubbleManager _bubbleManager = BubbleManager();
  final FirebaseController _controller = FirebaseController();

  @override
  void initState() {
    super.initState();
    _controller.init(); // init load data + fcm
  }

  @override
  Widget build(BuildContext context) {
    return BubbleScope(
      manager: _bubbleManager,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'FCM Chat',
        theme: ThemeData(primarySwatch: Colors.green),
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(builder: (_) => child ?? const SizedBox.shrink()),
              OverlayEntry(builder: (_) => const BubbleOverlay()),
            ],
          );
        },
        // Entry đầu tiên là SplashScreen
        home: SplashScreen(controller: _controller),
      ),
    );
  }
}







