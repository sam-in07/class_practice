import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class PhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoController());
  }
}