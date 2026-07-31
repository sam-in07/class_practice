import 'package:get/get.dart';

import '../controllers/post_controller.dart';


class PostBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()         =>          PostController()); //This line registers the PostController with GetX. "When someone requests a PostController, create one if it doesn't already exist."
    //Fetching posts from an API
  }
}