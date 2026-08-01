import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<UserModel>> fetchUsers() async {
    try {
      var response = await _dio.get('/users');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => UserModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}