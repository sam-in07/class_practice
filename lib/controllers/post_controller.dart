import 'package:get/get.dart';

import '../models/post_model.dart';
import '../network/postApiService.dart';


class PostController extends GetxController{

  RxList<PostModel> _posts = <PostModel>[].obs; //This creates a reactive list. Initially it is empty. Whenever the list changes, GetX automatically updates every Obx widget listening to it.
  RxBool _isLoading = false.obs;

  fetchPosts() async{
    _isLoading.value = true;
    _posts.assignAll(await Postapiservice().fetchPosts()); //(The controller waits until the API returns a list. ) Because assignAll() updates the existing reactive list.Every Obx listening to _posts is automatically notified.
   //Why Use assignAll()?  Keeps the same RxList instance.Automatically notifies Obx.
    _isLoading.value = false;
    //The underscore (_) makes them private.the controller controls all updates.
  }

  List<PostModel> get posts => _posts;

  bool get isLoading => _isLoading.value;

}