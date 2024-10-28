import 'package:flood_monitor/utils/color.dart';
import './component/ObjekTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/mapView.dart';

class homePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        scaffoldBackgroundColor: Color(0xFFEBF0F7),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor:
              Color(0xFFEBF0F7), // Menggunakan warna heksadesimal #EBF0F7
          body: Container(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              children: [
                Container(
                  height: hp * 0.3,
                  width: wp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(
                          4.0,
                          4.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: mapView(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(
                                4.0,
                                4.0,
                              ),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: ObjekTab()), // Panggil TabExample di sini
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
