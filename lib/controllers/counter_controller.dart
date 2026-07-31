import 'package:get/get.dart';

class CounterController extends GetxController{

  final RxInt _counter = 0.obs;

  void increment() {
    _counter.value += 1;
  }

  int get counter => _counter.value;

}