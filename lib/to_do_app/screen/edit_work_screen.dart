import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dna/to_do_app/model/task.dart';
import 'package:dna/to_do_app/screen/task_screen.dart';
import 'package:dna/to_do_app/widget/gradient_button_widget.dart';
import 'package:dna/to_do_app/widget/task_form_body.dart';
import 'package:dna/to_do_app/control/task_submit.dart';

// Man hình chỉnh sửa công việc
class EditWorkScreen extends StatefulWidget {
  final Task task;
  final int index;
  const EditWorkScreen({super.key, required this.task, required this.index});

  @override
  State<EditWorkScreen> createState() => _EditWorkScreenState();
}

class _EditWorkScreenState extends State<EditWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final ValueNotifier<DateTime?> _deadlineNotifier;
  late final ValueNotifier<TaskStatus> _statusNotifier;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
    _deadlineNotifier = ValueNotifier(
      DateFormat('dd/MM/yyyy').parse(widget.task.deadline),
    );
    _statusNotifier = ValueNotifier(widget.task.status);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _deadlineNotifier.dispose();
    _statusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // Text 
          title: const Text("Chỉnh sửa công việc", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Poppin", color: Colors.white)),
          backgroundColor: Colors.blue,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: TaskFormBody(
          formKey: _formKey,
          titleController: _titleController,
          descController: _descController,
          deadlineNotifier: _deadlineNotifier,
          statusNotifier: _statusNotifier,
          createdAt: widget.task.createdAt,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // button lưu công việc
              _buildGradientButton("Lưu công việc", _submitTask),
              const SizedBox(height: 12),
              // button chi tiết công việc
              _buildGradientButton("Chi tiết công việc", _openDetailScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return GradientButton(text: text, onPressed: onPressed);
  }
  
  // Xử lí thông tin và lưu task sau thay đổi 
  void _submitTask() async {
    final updatedTask = await handleSubmitTask(
    context: context,
    formKey: _formKey,
    titleController: _titleController,
    descController: _descController,
    deadlineNotifier: _deadlineNotifier,
    status: _statusNotifier.value,
    createdAt: widget.task.createdAt,
    );
    if (updatedTask != null) {
      Navigator.pop(context, updatedTask);
    }
  }
  
  // Xủ lí phần xem chi tiết 
  void _openDetailScreen() {
    final currentTask = Task(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      createdAt: widget.task.createdAt,
      deadline: DateFormat('dd/MM/yyyy').format(_deadlineNotifier.value!),
      status: _statusNotifier.value,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskScreen(index: widget.index, task: currentTask),
      ),
    );
  }
}


