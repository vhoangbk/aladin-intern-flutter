import 'package:dna/du_bao_thoi_tiet/screen/province_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  Widget build (BuildContext context){
    return MaterialApp(
      home: ProvinceScreen(),
    );
  }
}