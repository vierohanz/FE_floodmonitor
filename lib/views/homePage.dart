import 'package:flood_monitor/utils/color.dart';
import './component/ObjekTab.dart';
import 'component/WaterLevel.dart';
import 'package:flood_monitor/views/component/WaterLevel.dart';
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
              SizedBox(
                height: 20,
              ),
              WaterLevelCard(
                currentHeight: 154, // Ketinggian air saat ini
                predictedHeight: 126, // Prediksi ketinggian air
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Expanded(
                  child: ObjekTab(), // Panggil TabExample di sini
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
