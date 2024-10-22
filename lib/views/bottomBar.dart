import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/views/homePage.dart';
import 'package:flood_monitor/views/messagePage.dart';
import 'package:flood_monitor/views/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../controllers/bottomBarController.dart';

class bottomBar extends StatelessWidget {
  final bottomBarC = Get.put(bottomBarController());

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFEBF0F7)),
        child: Column(
          children: [
            Container(
              height: hp * 0.19,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/appbar.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: hp * 0.075,
                    left: wp * 0.04,
                    right: wp * 0.04,
                    bottom: hp * 0.03),
                height: hp * 0.1,
                width: wp * 1,
                // decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  children: [
                    Container(
                      width: wp * 0.3,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Text(
                        "SIAGA",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: wp * 0.04),
                      )),
                    ),
                    Container(
                      width: wp * 0.5,
                      height: hp * 1,
                      margin: EdgeInsets.all(7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pekalongan",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w900,
                                  fontSize: wp * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Rabu, 2 Oktober 2024 15.30 WIB",
                                style: TextStyle(
                                  fontFamily: "NunitoSans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: wp * 0.027,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: wp * 0.02,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.repeat, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: hp * 0.728,
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
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 17),
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
