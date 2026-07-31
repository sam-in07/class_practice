import 'package:get/get.dart';
import '../bindings/comment_binding.dart';
import '../bindings/counter_binding.dart';
import '../bindings/post_binding.dart';
import '../pages/comments_page.dart';
import '../pages/counter.dart';
import '../pages/posts.dart';


class Pages {
  List<GetPage> getAllPages() {
    return [
      GetPage(name: '/counter', page: () => Counter(), binding: CounterBinding()),
      GetPage(name: '/post', page: () => Posts(), binding: PostBinding()),
      GetPage(
        name: '/comments',
        page: () => CommentsPage(),
        binding: CommentBinding(),
      ),
    ];
  }
}