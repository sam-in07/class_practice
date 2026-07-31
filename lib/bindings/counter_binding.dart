import 'package:get/get.dart';

import '../controllers/counter_controller.dart';


class CounterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CounterController());
  }
}