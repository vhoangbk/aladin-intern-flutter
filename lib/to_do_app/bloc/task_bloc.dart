import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dna/to_do_app/bloc/task_event.dart';
import 'package:dna/to_do_app/bloc/task_state.dart';
import 'package:dna/to_do_app/model/task.dart';
import 'package:dna/to_do_app/storage/task_storage.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskStorage _storage = TaskStorage(); // Lưu file 
  List<Task> _tasks = [];

  TaskBloc() : super(const TaskState()) {
    // Load công việc
    on<LoadTasks>((event, emit) async {
      _tasks = await _storage.readTasks();
      emit(TaskState(tasks: List.from(_tasks)));
    });
    
    //Thêm công việc
    on<AddTask>((event, emit) async {
      _tasks.add(event.task);
      emit(state.copyWith(tasks: List.from(_tasks)));
    });
    
    // Chỉnh sửa công việc
    on<UpdateTask>((event, emit) async {
      final index = _tasks.indexOf(event.oldTask);
      if (index != -1) {
        _tasks[index] = event.updatedTask;
        await _storage.writeTasks(_tasks);
        emit(state.copyWith(tasks: List.from(_tasks)));
      }
    });
    
    //Xóa công việc
    on<DeleteTask>((event, emit) async {
      _tasks.remove(event.task);
      await _storage.writeTasks(_tasks);
      emit(state.copyWith(tasks: List.from(_tasks)));
    });
    
    // Lưu công việc 
    on<SaveTasks>((event, emit) async {
      await _storage.writeTasks(state.tasks); // chỉ lưu khi có event SaveTasks
    });
  }
}

