import 'package:flutter/material.dart';
import 'package:dna/to_do_app/model/task.dart';
import 'edit_work_screen.dart'; 
import 'package:dna/to_do_app/widget/gradient_button_widget.dart';
import 'package:dna/to_do_app/control/delete_button.dart';

// Màn hình xem chi tiết 
class TaskScreen extends StatelessWidget {
  final int index;
  final Task task;

  const TaskScreen({super.key, required this.index, required this.task});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Task ${index + 1}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Poppin", color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên công việc", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin",)),
            SizedBox(height: 4),
            Text(task.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"),),
            SizedBox(height: 50),

            Text("Mô tả chi tiết công việc",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin",)),
            SizedBox(height: 4),
            Text(task.description, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"), ),
            SizedBox(height: 150),

            Text("Ngày tạo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin",)),
            Text(task.createdAt,  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"),),
            SizedBox(height: 8),
            Text("Ngày hết hạn", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin",)),
            Text(task.deadline,  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"),),
            SizedBox(height: 8),
            Text("Trạng thái: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin",)),
            Text(
              task.status.name,
              style: TextStyle(color: task.status.color, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"),
            ),

            Spacer(),
            Row(
              children: [
                Expanded(
                  child: GradientButton(
                    // Xử lí nút quay về chỉnh sửa công việc
                    text: "Chỉnh sửa công việc",
                    onPressed: () async {
                      final editedTask = await Navigator.push<Task>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditWorkScreen(task: task, index: index),
                        ),
                      );
                      if (editedTask != null) {
                        Navigator.pop(context, editedTask);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GradientButton(
                    // Xử lí button xóa
                    backgroundColor: Colors.redAccent,
                    text: "Xoá",
                    onPressed: () {
                      confirmDeleteTask(
                        context: context,
                        task: task,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}



