import 'package:flutter/material.dart';
import 'package:get/get.dart';

class appBarIconController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;

  double rotationValue = 0;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: Duration(milliseconds: 900),
      vsync: this,
    );

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void onIconPressed() {
    if (animationController.isAnimating) return;
    rotationValue += 1;

    rotationAnimation =
        Tween<double>(begin: rotationValue - 1, end: rotationValue).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward(from: 0);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
