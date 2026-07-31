import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/album_controller.dart';

class AlbumsPage extends GetView<AlbumController> {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchAlbums(),
        child: const Icon(CupertinoIcons.refresh),
      ),
      body: Obx(
            () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.albums.length,
          itemBuilder: (context, index) {
            final album = controller.albums[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(album.id.toString()),
              ),
              title: Text(album.title),
              subtitle: Text("User ID: ${album.userId}"),
            );
          },
        ),
      ),
    );
  }
}