import 'package:dio/dio.dart';
import '../models/photo_model.dart';

class AlbumApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<AlbumModel>> fetchAlbums() async {
    try {
      var response = await _dio.get('/albums');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => AlbumModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}