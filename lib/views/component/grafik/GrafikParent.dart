import 'package:flood_monitor/views/component/grafik/CurahHujan.dart';
import 'package:flood_monitor/views/component/grafik/KetinggianAir.dart';
import 'package:flutter/material.dart';

class GrafikTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        child: Column(
          children: [
            CurahHujan(),
            KetinggianAir(),
          ],
        ), // Gunakan class CurahHujan di sini
      ),
    );
  }
}
