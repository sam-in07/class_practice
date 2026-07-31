import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/post_controller.dart';

class Posts extends GetView<PostController> {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchPosts();
        },
        child: Icon(CupertinoIcons.refresh),
      ),
      appBar: AppBar(title: Text("Api Call Example"), centerTitle: true),
      body: Obx(
            () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.posts[index].title),
              subtitle: Text(controller.posts[index].body),
            );
          },
        ),
      ),
    );
  }
}