import 'package:get/get.dart';
import '../models/album_model.dart';
import '../network/album_api_service.dart';

class AlbumController extends GetxController {
  final AlbumApiService _apiService = AlbumApiService();

  final RxList<AlbumModel> _albums = <AlbumModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<AlbumModel> get albums => _albums;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchAlbums();
  }

  void fetchAlbums() async {
    _isLoading.value = true;
    try {
      var result = await _apiService.fetchAlbums();
      _albums.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}