import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dna/to_do_app/model/task.dart';

// Cấu trúc chung của màn hình AddScreen và EditScreen và cách xử lí logic khi nhập liệu trong ô Text
class TaskFormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descController;
  final ValueNotifier<DateTime?> deadlineNotifier;
  final ValueNotifier<TaskStatus>? statusNotifier;
  final String? createdAt;

  const TaskFormBody({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descController,
    required this.deadlineNotifier,
    this.statusNotifier,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _buildInput("Tên công việc", titleController),
            const SizedBox(height: 16),
            _buildInput("Mô tả chi tiết công việc", descController, maxLines: 4),
            if (createdAt != null) ...[
              const SizedBox(height: 16),
              Text("Ngày tạo: $createdAt", style: const TextStyle(fontSize: 15, fontFamily: "Poppin", fontWeight: FontWeight.w700)),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Ngày hết hạn:", style: TextStyle(fontSize: 15, fontFamily: "Poppin", fontWeight: FontWeight.w700)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: deadlineNotifier.value ?? now,
                      firstDate: now,
                      lastDate: DateTime(now.year + 5),
                    );
                    if (picked != null) deadlineNotifier.value = picked;
                  },
                  // Button chọn ngày hết hạn
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 238, 196, 236),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    elevation: 0,
                  ),
                  child: const Text("Select day", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: "Poppin")),
                ),
              ],
            ),
            
            // Xử lí phần lịch hiển thị ngày hết hạn 
            ValueListenableBuilder<DateTime?>(
              valueListenable: deadlineNotifier,
              builder: (context, deadline, _) {
                if (deadline == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Hết hạn: ${DateFormat('dd/MM/yyyy').format(deadline)}",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"),
                  ),
                );
              },
            ),
            if (statusNotifier != null) ...[
              const SizedBox(height: 24),
              ValueListenableBuilder<TaskStatus>(
                valueListenable: statusNotifier!,
                builder: (context, status, _) => Row(
                  children: [
                    const Text("Trạng thái: ", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: "Poppin")),
                    DropdownButton<TaskStatus>(
                      value: status,
                      items: TaskStatus.values.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(s.name, style: TextStyle(color: s.color)),
                        );
                      }).toList(),
                      onChanged: (newStatus) {
                        if (newStatus != null) statusNotifier!.value = newStatus;
                      },
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  // Xử lí logic chung ở ô nhập Tên Công Việc
  Widget _buildInput(String hint, TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (hint.contains("Tên") && (value == null || value.trim().isEmpty)) {
          return "Vui lòng nhập tên công việc";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

