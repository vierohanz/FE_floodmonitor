import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarIconController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  late Animation<double> verticalAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this, // GetTickerProviderStateMixin provides this
    );

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    verticalAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void onIconPressed() {
    if (animationController.isAnimating)
      return; // Prevent overlapping animations

    animationController.forward().then((_) {
      animationController.reverse();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
