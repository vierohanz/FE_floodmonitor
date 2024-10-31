import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/views/appBar.dart';
import 'package:flood_monitor/views/homePage.dart';
import 'package:flood_monitor/views/messagePage.dart';
import 'package:flood_monitor/views/profilePage.dart';
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
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(200.0), child: appBar()),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEBF0F7)),
        child: Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: bottomBarC.pageController,
            children: [
              homePage(),
              messagePage(),
              profilePage(),
            ],
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  icon: FaIcon(FontAwesomeIcons.facebookMessenger),
                  title: Text('Message'),
                  activeColor: Colors.red,
                ),
                BottomBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Account'),
                  activeColor: Colors.greenAccent.shade700,
                ),
              ],
            ),
          )),
    );
  }
}
