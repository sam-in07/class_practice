import 'dart:developer';
import 'package:dio/dio.dart'; //http request
import '../models/post_model.dart';

class Postapiservice {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  fetchPosts() async {
    try {
      var _response = await _dio.get('/posts');

      if (_response.statusCode == 200) {
        List<dynamic> data = _response.data;

        log(data.toString());

        return data.map((item) {
          return PostModel(
            userId: item['userId'],
            id: item['id'],
            title: item['title'],
            body: item['body'],
          );
        }).toList();
      } else {
        throw Exception('API could not be reached');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}