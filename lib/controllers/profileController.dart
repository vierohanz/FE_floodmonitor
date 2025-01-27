import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;

  final List<Map<String, dynamic>> menuItems = [
    {"text": "My Account", "icon": Icons.person, "press": () {}},
    {"text": "Notifications", "icon": Icons.notifications, "press": () {}},
    {"text": "Settings", "icon": Icons.settings, "press": () {}},
    {"text": "Help Center", "icon": Icons.help, "press": () {}},
    {"text": "Log Out", "icon": Icons.logout, "press": () {}},
  ];

  @override
  void onInit() {
    super.onInit();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }
}
