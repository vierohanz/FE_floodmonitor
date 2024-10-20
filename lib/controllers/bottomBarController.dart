import 'package:flood_monitor/models/bottomBarModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class bottomBarController extends GetxController {
  final bottomBarModel model = bottomBarModel();
  PageController pageController = PageController();

  void changePage(int index) {
    model.currentPage.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
