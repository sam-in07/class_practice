import 'package:get/get.dart';
import '../models/todo_model.dart';
import '../network/todo_api_service.dart';

class PhotoController extends GetxController {
  final PhotoApiService _apiService = PhotoApiService();

  final RxList<PhotoModel> _photos = <PhotoModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<PhotoModel> get photos => _photos;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    // Retrieve albumId if passed via Get.arguments, else fetch all
    int? albumId = Get.arguments as int?;
    fetchPhotos(albumId: albumId);
  }

  void fetchPhotos({int? albumId}) async {
    _isLoading.value = true;
    try {
      var result = await _apiService.fetchPhotos(albumId: albumId);
      _photos.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}