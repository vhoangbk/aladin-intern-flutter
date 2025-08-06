import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/button_tabbar.dart';

class ScheduleTabbar extends StatefulWidget {
  const ScheduleTabbar({super.key});

  @override
  State<ScheduleTabbar> createState() => _ScheduleTabbarState();
}

class _ScheduleTabbarState extends State<ScheduleTabbar> {
  @override
  Widget build(BuildContext context) {
    final _ = context.locale; // rebuild khi đổi ngôn ngữ

    return Scaffold(
      body: Column(
        children: [
          ButtonTabbar(title: "Workout Schedule".tr()) // dịch 
        ],
      ),
    );
  }
}
