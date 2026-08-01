import 'package:dio/dio.dart';
import '../models/todo_model.dart';

class TodoApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<TodoModel>> fetchTodos() async {
    try {
      var response = await _dio.get('/todos');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => TodoModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}