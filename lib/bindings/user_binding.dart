import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}