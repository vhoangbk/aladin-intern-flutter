import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/button_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileTabbar extends StatefulWidget {
  const ProfileTabbar({super.key});

  @override
  State<ProfileTabbar> createState() => _ProfileTabbarState();
}

class _ProfileTabbarState extends State<ProfileTabbar> {
  @override
  Widget build(BuildContext context) {
    final _ = context.locale; // rebuild khi đổi locale

    return Scaffold(
      body: Column(
        children: [
          ButtonTabbar(title: "Profile".tr()) // Hiển thị đúng bản dịch
        ],
      ),
    );
  }
}

