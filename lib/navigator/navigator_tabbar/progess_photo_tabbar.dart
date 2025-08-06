import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/button_tabbar.dart';

class ProgessPhotoTabbar extends StatefulWidget {
  const ProgessPhotoTabbar({super.key});

  @override
  State<ProgessPhotoTabbar> createState() => _ProgessPhotoTabbarState();
}

class _ProgessPhotoTabbarState extends State<ProgessPhotoTabbar> {
  @override
  Widget build(BuildContext context) {
    final _ = context.locale; // rebuild khi ngôn ngữ thay đổi

    return Scaffold(
      body: Column(
        children: [
          ButtonTabbar(title: "Progress Photo".tr()) 
        ],
      ),
    );
  }
}
