import 'package:get/get.dart';
import '../models/comment_model.dart';
import '../network/comment_api_service.dart';

class CommentController extends GetxController {
  final CommentApiService _apiService = CommentApiService();

  final RxList<CommentModel> _comments = <CommentModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<CommentModel> get comments => _comments;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the postId passed from Get.toNamed('/comments', arguments: postId)
    if (Get.arguments != null) {
      int postId = Get.arguments as int;
      fetchComments(postId);
    }
  }

  void fetchComments(int postId) async {
    _isLoading.value = true;
    try {
      var result = await _apiService.fetchCommentsByPostId(postId);
      _comments.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}