import 'package:get/get.dart';
import '../models/user_model.dart';
import '../network/user_api_service.dart';

class UserController extends GetxController {
  final UserApiService _apiService = UserApiService();

  final RxList<UserModel> _users = <UserModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    _isLoading.value = true;
    try {
      var result = await _apiService.fetchUsers();
      _users.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}