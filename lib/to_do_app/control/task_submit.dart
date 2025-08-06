import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dna/to_do_app/model/task.dart'; 

// Xác nhận deadline và tạo Task mới 
Future<Task?> handleSubmitTask({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController titleController,
  required TextEditingController descController,
  required ValueNotifier<DateTime?> deadlineNotifier,
  TaskStatus status = TaskStatus.todo,
  String? createdAt,
}) async {
  if (!formKey.currentState!.validate()) return null;
  // Xử lí deadline
  final deadline = deadlineNotifier.value;
  if (deadline == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Vui lòng chọn ngày hết hạn")),
    );
    return null;
  }

  // Tạo thông tin task mới 
  return Task(
    title: titleController.text.trim(),
    description: descController.text.trim(),
    createdAt: createdAt ?? DateFormat('dd/MM/yyyy').format(DateTime.now()),
    deadline: DateFormat('dd/MM/yyyy').format(deadline),
    status: status,
  );
}
