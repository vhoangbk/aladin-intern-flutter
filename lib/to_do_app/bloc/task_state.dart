import 'package:equatable/equatable.dart';
import 'package:dna/to_do_app/model/task.dart';

class TaskState extends Equatable {
  final List<Task> tasks;

  const TaskState({
    this.tasks = const [],
  });

  TaskState copyWith({
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }
  
  @override
  List<Object?> get props => [tasks]; 
}
