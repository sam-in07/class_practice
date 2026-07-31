import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/counter_controller.dart';

class Counter extends GetView<CounterController> {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        child: Icon(CupertinoIcons.add),
      ),
      body: Center(
        child: Obx(
              () => Text(
            controller.counter.toString(),
            style: TextStyle(fontSize: 31, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}



