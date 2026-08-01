import 'package:class_practice/bindings/counter_binding.dart';
import 'package:class_practice/pages/counter.dart';
import 'package:class_practice/pages/user_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bindings/user_binding.dart';
import 'bindings/post_binding.dart';
import 'get pages/pages.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/users',
      initialBinding: UserBinding(),
      getPages: Pages().getAllPages(),
      home: UsersPage(),
    );
  }
}
