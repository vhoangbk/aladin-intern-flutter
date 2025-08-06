import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Các trạng thái công việc và dữ liệu trong app

// Trạng thái công việc
enum TaskStatus {
  todo,
  inProgress,
  done,
}

extension TaskStatusExt on TaskStatus {
  String get name {
    switch (this) {
      case TaskStatus.todo:
        return "To do";
      case TaskStatus.inProgress:
        return "In progress";
      case TaskStatus.done:
        return "Done";
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.todo:
        return Colors.red;
      case TaskStatus.inProgress:
        return Colors.purple;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  static TaskStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'to do':
        return TaskStatus.todo;
      case 'in progress':
        return TaskStatus.inProgress;
      case 'done':
        return TaskStatus.done;
      default:
        return TaskStatus.todo;
    }
  }
}

// Kế thừa từ Equatable để hỗ trợ so sánh task đúng
class Task extends Equatable{
  final int? id;
  final String title;
  final String description;
  final String createdAt;
  final String deadline;
  final TaskStatus status;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadline,
    this.status = TaskStatus.todo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdAt': createdAt,
        'deadline': deadline,
        'status': status.name,
      };

  factory Task.fromJson(Map<String, dynamic> map) => Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        createdAt: map['createdAt'],
        deadline: map['deadline'],
        status: TaskStatusExt.fromString(map['status']),
      );

  @override
  List<Object?> get props => [title, description, createdAt, deadline, status];
}
