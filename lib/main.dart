import 'package:flood_monitor/controllers/bottomBarController.dart';
import 'package:flood_monitor/views/bottomBar.dart';
import 'package:flood_monitor/views/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/',
          page: () => bottomBar(),
          binding: BindingsBuilder(() {
            Get.put(bottomBarController());
          }),
        ),
      ],
    );
  }
}
