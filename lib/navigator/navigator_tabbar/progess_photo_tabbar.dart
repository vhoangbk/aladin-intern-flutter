import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/button_tabbar.dart';

class ProgessPhotoTabbar extends StatelessWidget {
  const ProgessPhotoTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonTabbar(title: "Progress Photo")
        ],
      )
    );
  }
}