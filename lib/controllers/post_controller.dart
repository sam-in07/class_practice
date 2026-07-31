import 'package:get/get.dart';

import '../models/post_model.dart';
import '../network/postApiService.dart';


class PostController extends GetxController{

  RxList<PostModel> _posts = <PostModel>[].obs;
  RxBool _isLoading = false.obs;

  fetchPosts() async{
    _isLoading.value = true;
    _posts.assignAll(await Postapiservice().fetchPosts());
    _isLoading.value = false;
  }

  List<PostModel> get posts => _posts;

  bool get isLoading => _isLoading.value;

}