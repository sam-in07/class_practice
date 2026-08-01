import 'package:get/get.dart';
import '../models/todo_model.dart';
import '../network/todo_api_service.dart';

class TodoController extends GetxController {
  final TodoApiService _apiService = TodoApiService();

  final RxList<TodoModel> _todos = <TodoModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() async {
    _isLoading.value = true;
    try {
      var result = await _apiService.fetchTodos();
      _todos.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}