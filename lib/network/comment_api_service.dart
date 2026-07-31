import 'package:dio/dio.dart';
import '../models/comment_model.dart';

class CommentApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Fetch comments for a specific post
  Future<List<CommentModel>> fetchCommentsByPostId(int postId) async {
    try {
      var response = await _dio.get(
        '/comments',
        queryParameters: {'postId': postId}, // Requests: /comments?postId=1
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CommentModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}