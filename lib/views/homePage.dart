import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/view/TabExample.dart';
import 'package:flood_monitor/view/waterlevelcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        scaffoldBackgroundColor: Color(0xFFEBF0F7),
      ),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: Scaffold(
        backgroundColor:
            Color(0xFFEBF0F7), // Menggunakan warna heksadesimal #EBF0F7
        body: Container(
            child: Container(
          child: Column(
            children: [
              WaterLevelCard(
                currentHeight: 154, // Ketinggian air saat ini
                predictedHeight: 126, // Prediksi ketinggian air
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Expanded(
                  child: CustomTabExample(), // Panggil TabExample di sini
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
