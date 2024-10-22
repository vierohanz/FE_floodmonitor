import 'package:flood_monitor/views/homePage.dart';
import 'package:flood_monitor/views/messagePage.dart';
import 'package:flood_monitor/views/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../controllers/bottomBarController.dart';

class BottomBarWidget extends StatelessWidget {
  final bottomBarC = Get.find<bottomBarController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(16.0), // Set margin for PageView
          child: PageView(
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
        bottomNavigationBar: Obx(() => Container(
              margin: const EdgeInsets.symmetric(horizontal: 17),
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
      ),
    );
  }
}
