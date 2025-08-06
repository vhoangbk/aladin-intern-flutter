import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dna/to_do_app/bloc/task_bloc.dart';
import 'package:dna/to_do_app/bloc/task_event.dart';
import 'package:dna/to_do_app/model/task.dart';

// Xử lí cho các nút xóa ở trong app
void confirmDeleteTask({
  required BuildContext context,
  required Task task,
  required int index,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Xác nhận xóa", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Poppin")),
      content: Text("Bạn có muốn xóa Task ${index + 1} không?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Hủy", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.settings.name == '/');
            context.read<TaskBloc>().add(DeleteTask(task));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Đã xoá: Task ${index + 1}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"))),
            );
          },
          child: const Text("Xóa", style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
        ),
      ],
    ),
  );
}
