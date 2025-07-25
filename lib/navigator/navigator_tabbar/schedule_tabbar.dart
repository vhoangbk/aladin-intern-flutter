import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/button_tabbar.dart';

class ScheduleTabbar extends StatelessWidget {
  const ScheduleTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonTabbar(title: "Workout Schedule")
        ],
      )
    );
  }
}