import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/views/appBar.dart';
import 'package:flood_monitor/views/homePage.dart';
import 'package:flood_monitor/views/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../controllers/bottomBarController.dart';

class bottomBar extends StatelessWidget {
  // Change class name to follow convention
  final bottomBarC = Get.put(bottomBarController());

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEBF0F7)),
        child: Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: bottomBarC.pageController,
            children: [homePage(), ProfileScreen()],
            onPageChanged: (index) {
              bottomBarC.changePage(index);
            },
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: BottomBar(
              selectedIndex: bottomBarC.model.currentPage.value,
              onTap: (int index) {
                bottomBarC.changePage(index);
              },
              items: <BottomBarItem>[
                BottomBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  activeColor: Colors.blue,
                ),
                BottomBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 15, // Ubah ukuran ikon di sini
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(fontSize: 16), // Ubah ukuran teks di sini
                  ),
                  activeColor: Colors.red,
                )
                // BottomBarItem(
                //   icon: FaIcon(FontAwesomeIcons.facebookMessenger),
                //   title: Text('Message'),
                //   activeColor: Colors.red,
                // ),
              ],
            ),
          )),
    );
  }
}
