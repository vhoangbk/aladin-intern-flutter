import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dna/to_do_app/model/task.dart';

// Lưu trữ và đọc các danh sách công việc đã lưu
class TaskStorage {
  static const _fileName = 'tasks.json';
  
  // Lấy file để đọc và ghi 
  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }
  
  // Đọc dữ liệu file
  Future<List<Task>> readTasks() async {
    try {
      final file = await _getFile();
      if (!file.existsSync()) return [];
      final content = await file.readAsString();
      final jsonList = json.decode(content) as List;
      return jsonList.map((e) => Task.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }
  
  // Lưu dữ liệu vào file
  Future<void> writeTasks(List<Task> tasks) async {
    final file = await _getFile();
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
