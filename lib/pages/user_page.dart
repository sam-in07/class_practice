import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UsersPage extends GetView<UserController> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Directory"),
        centerTitle: true,
      ),
      body: Obx(
            () => controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ExpansionTile(
                leading: CircleAvatar(
                  child: Text(user.name[0]), // First letter of name
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("@${user.username} | ${user.email}"),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("📞 Phone: ${user.phone}"),
                        Text("🌐 Website: ${user.website}"),
                        const SizedBox(height: 8),
                        Text("📍 Address: ${user.address.street}, ${user.address.city}"),
                        Text("🏢 Company: ${user.company.name}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}