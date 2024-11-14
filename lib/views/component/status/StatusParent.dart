import 'package:flood_monitor/views/component/status/StatusTerakhir.dart';
import 'package:flutter/material.dart';

class StatusParent extends StatelessWidget {
  const StatusParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StatusTerakhirTab(),
        StatusTerakhirTab(),
      ],
    );
  }
}
