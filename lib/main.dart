import 'package:bottom_bar/bottom_bar.dart';
import 'package:flood_monitor/controllers/bottomBarController.dart';
import 'package:flood_monitor/views/bottomBar.dart';
import 'package:flood_monitor/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => BottomBarWidget(),
          binding: BindingsBuilder(() {
            Get.put(bottomBarController());
          }),
        ),
      ],
    );
  }
}
