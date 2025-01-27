import 'package:flood_monitor/views/component/profile/profileMenu.dart';
import 'package:flood_monitor/views/component/profile/profilePic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/profileController.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileC = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(fontFamily: "Nunito Sans"),
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const profilePic(),
              const SizedBox(height: 20),
              profileC.isLoading.value
                  ? _buildShimmerEffect()
                  : _buildProfileMenu(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileMenu() {
    return Column(
      children: profileC.menuItems.map((item) {
        return profileMenu(
          text: item['text'],
          icon: item['icon'],
          press: item['press'],
        );
      }).toList(),
    );
  }
}
