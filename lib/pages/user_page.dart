import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class TodosPage extends GetView<TodoController> {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos List"),
        centerTitle: true,
      ),
      body: Obx(
            () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return CheckboxListTile(
              value: todo.completed,
              onChanged: (val) {
                // Read-only UI toggle example
              },
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.completed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text("User ID: ${todo.userId} | Task #${todo.id}"),
            );
          },
        ),
      ),
    );
  }
}