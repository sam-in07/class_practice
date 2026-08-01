import 'package:get/get.dart';
import '../controllers/photo_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlbumController());
  }
}