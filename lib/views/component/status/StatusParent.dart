import 'package:flood_monitor/views/component/status/StatusTerakhir_1.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_2.dart';
import 'package:flutter/material.dart';

class StatusParent extends StatelessWidget {
  const StatusParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StatusTerakhir1Tab(),
        StatusTerakhir2Tab(),
      ],
    );
  }
}
