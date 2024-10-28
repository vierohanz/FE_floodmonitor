import 'package:flood_monitor/controllers/appBarController.dart';
import 'package:flood_monitor/controllers/appBarIconController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class appBar extends StatelessWidget {
  final appBarC = Get.put(appBarController());
  final appBarIconC = Get.put(appBarIconController());
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return Container(
      height: hp * 0.19,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
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
            top: hp * 0.065,
            left: wp * 0.04,
            right: wp * 0.04,
            bottom: hp * 0.03),
        height: hp * 0.1,
        width: wp * 1,
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
                "BANJIR",
                style: TextStyle(
                    fontFamily: "NunitoSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: wp * 0.04),
              )),
            ),
            Container(
              width: wp * 0.45,
              height: hp * 1,
              margin: EdgeInsets.only(top: 7, left: 40, bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${appBarC.appBarM.value.location}",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.w900,
                            fontSize: wp * 0.055,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${appBarC.getFormattedDate()}",
                          style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontWeight: FontWeight.w600,
                            fontSize: wp * 0.029,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: wp * 0.1,
                    child: IconButton(
                      icon: AnimatedBuilder(
                        animation: appBarIconC.animationController,
                        builder: (context, child) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(
                                appBarIconC.rotationAnimation.value *
                                    2 *
                                    3.14159),
                            child: Icon(Icons.repeat, color: Colors.white),
                          );
                        },
                      ),
                      onPressed: () => [
                        appBarIconC.onIconPressed(),
                        appBarC.changeLocation()
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
