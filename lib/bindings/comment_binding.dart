import 'package:get/get.dart';
import '../controllers/comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    // Registers CommentController lazily (instantiated only when CommentsPage is opened)
    Get.lazyPut(() => CommentController());
  }
}