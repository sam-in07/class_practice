import 'package:get/get.dart';

import '../controllers/post_controller.dart';


class PostBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PostController());
  }
}