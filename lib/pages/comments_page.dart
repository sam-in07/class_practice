import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/comment_controller.dart';

// Use GetView<CommentController> to access your controller directly via 'controller'
class CommentsPage extends GetView<CommentController> {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
        centerTitle: true,
      ),
      body: Obx(
            () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.comments.length,
          itemBuilder: (context, index) {
            final comment = controller.comments[index];
            return Card(
              child: ListTile(
                title: Text(comment.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.email, style: const TextStyle(color: Colors.blue)),
                    const SizedBox(height: 4),
                    Text(comment.body),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}