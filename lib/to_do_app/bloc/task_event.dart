import 'package:equatable/equatable.dart';
import 'package:dna/to_do_app/model/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent{}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}


class UpdateTask extends TaskEvent {
  final Task oldTask;
  final Task updatedTask;

  const UpdateTask(this.oldTask, this.updatedTask);

  @override
  List<Object?> get props => [oldTask, updatedTask];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask(this.task);

  @override
  List<Object?> get props => [task];
}

class SaveTasks extends TaskEvent {
  const SaveTasks();

  @override
  List<Object?> get props => [];
}

