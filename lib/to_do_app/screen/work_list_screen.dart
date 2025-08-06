import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dna/to_do_app/bloc/task_bloc.dart';
import 'package:dna/to_do_app/bloc/task_event.dart';
import 'package:dna/to_do_app/bloc/task_state.dart';
import 'package:dna/to_do_app/model/task.dart';
import 'package:dna/to_do_app/screen/add_work_screen.dart';
import 'package:dna/to_do_app/screen/edit_work_screen.dart';
import 'package:dna/to_do_app/widget/task_card_widget.dart';
import 'package:dna/to_do_app/screen/task_screen.dart';
import 'package:dna/to_do_app/control/delete_button.dart';


class WorkListScreen extends StatelessWidget {
 

  const WorkListScreen({super.key});

  void _handleMenu(BuildContext context, String value, Task task, int index) async {
  if (value == 'edit') {
    final Task? updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWorkScreen(task: task, index: index),
      ),
    );

    if (updated != null) {
      // Gửi sự kiện cập nhật
      context.read<TaskBloc>().add(UpdateTask(task, updated));
    }
  }
  else if (value == 'delete') {
    confirmDeleteTask(
      context: context,
      task: task,
      index: index, 
    );
  } else if (value == 'detail') {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskScreen(index: index, task: task),
      ),
    );

    if (result == 'delete') {
      context.read<TaskBloc>().add(DeleteTask(task));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đã xoá: Task ${index + 1}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"))),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách công việc", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Poppin", color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {                 
                  context.read<TaskBloc>().add(SaveTasks());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Đã lưu danh sách công việc!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")))
                  );                 
                },
                child: const Text("Lưu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Poppin")),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  final newTask = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddWorkScreen()),
                  );
                  if (newTask != null) {
                    context.read<TaskBloc>().add(AddTask(newTask));
                  }
                },
                child: const Text("Thêm", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Poppin")),
              )
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                final tasks = state.tasks;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => buildTaskCard(
                    context,
                    tasks[index],
                    index,
                    (value) => _handleMenu(context, value, tasks[index], index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}




