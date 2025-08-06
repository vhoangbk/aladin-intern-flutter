import 'package:dna/to_do_app/widget/task_form_body.dart';
import 'package:flutter/material.dart';
import 'package:dna/to_do_app/widget/gradient_button_widget.dart'; 
import 'package:dna/to_do_app/control/task_submit.dart';

// Màn hình tạo task
class AddWorkScreen extends StatefulWidget {
  const AddWorkScreen({super.key});

  @override
  State<AddWorkScreen> createState() => _AddWorkScreenState();
}

class _AddWorkScreenState extends State<AddWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _deadlineNotifier = ValueNotifier<DateTime?>(null);

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _deadlineNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          // Text
          title: const Text("Tạo công việc mới", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, fontFamily: "Poppin", color: Colors.white)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: TaskFormBody(
          formKey: _formKey,
          titleController: _titleController,
          descController: _descController,
          deadlineNotifier: _deadlineNotifier,
        ),

        // Xử lí nút "Thêm công việc"
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildGradientButton("Thêm công việc", _submitTask),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return GradientButton(text: text, onPressed: onPressed);
  }
  
  // Xác nhận thông tin và tạo task
  void _submitTask() async {
    final task = await handleSubmitTask(
      context: context,
      formKey: _formKey,
      titleController: _titleController,
      descController: _descController,
      deadlineNotifier: _deadlineNotifier,
    );

    if (task != null) {
      Navigator.pop(context, task);
    }
  }
}





