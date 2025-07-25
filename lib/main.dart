import 'package:dna/navigator/router/router.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build (BuildContext context)
  {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
