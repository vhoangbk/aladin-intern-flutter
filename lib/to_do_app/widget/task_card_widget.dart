import 'package:flutter/material.dart';
import 'package:dna/to_do_app/model/task.dart';


// Cấu trúc chung của 1 thẻ task hiển thị ở ngoài danh sách task
Widget buildTaskCard(BuildContext context, Task task, int index, Function(String) onMenuSelected){
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: ListTile(
      title: Text("Task ${index + 1}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppin")),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: "Poppin")),
          Text("Ngày tạo: ${task.createdAt}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
          Text("Ngày hết hạn: ${task.deadline}",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
          Text(
            task.status.name,
            style: TextStyle(color: task.status.color, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: "Poppin"),
          )
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: onMenuSelected,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            child: Text("Chỉnh sửa", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"))
          ),

          PopupMenuItem(
            value: 'delete',
            child: Text("Xóa", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"))
          ),
        ]
      ),
    )
  );
}