import 'package:dio/dio.dart';
import '../models/todo_model.dart';

class PhotoApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Fetch photos (supports filtering by albumId if passed)
  Future<List<PhotoModel>> fetchPhotos({int? albumId}) async {
    try {
      final queryParams = albumId != null ? {'albumId': albumId} : null;
      var response = await _dio.get('/photos', queryParameters: queryParams);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => PhotoModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}