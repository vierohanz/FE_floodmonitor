import 'package:flood_monitor/utils/color.dart';
import './component/ObjekTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/mapView.dart';

class homePage extends StatelessWidget {
  @override
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
        backgroundColor: Color(0xFFEBF0F7),
        body: Container(
          width: wp,
          padding: EdgeInsets.only(top: 12, right: 22, left: 22, bottom: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: hp * 0.02),
                child: Column(
                  children: [
                    Container(
                      width: wp,
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          topRight: Radius.circular(13),
                        ),
                      ),
                      child: Text(
                        "Titik Lokasi",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: "NunitoSans",
                            fontSize: wp * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 14, right: 14, left: 14, bottom: 14),
                      width: wp,
                      height: hp * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: mapView(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: hp * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: ObjekTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
