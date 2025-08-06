import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dna/to_do_app/screen/work_list_screen.dart';
import 'package:dna/to_do_app/bloc/task_bloc.dart';
import 'package:dna/to_do_app/bloc/task_event.dart';

void main() async { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc()..add(LoadTasks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: const WorkListScreen(), 
      ),
    );
  }
}


