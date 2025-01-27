import 'package:flood_monitor/views/component/grafik/GrafikParent.dart';
import 'package:flood_monitor/views/component/status/StatusParent.dart';
import 'package:flutter/material.dart';

class ObjekTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13)),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: TabBar(
                labelColor: const Color.fromARGB(255, 0, 0, 0),
                unselectedLabelColor: Colors.black,
                indicatorColor: const Color.fromARGB(255, 0, 132, 255),
                tabs: [
                  Tab(text: 'Status Terakhir'),
                  Tab(text: 'Grafik'),
                ],
              ),
            ),
            // Menggunakan Expanded agar TabBarView mengambil lebih banyak ruang
            Expanded(
              child: TabBarView(
                children: [
                  StatusParent(),
                  GrafikTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(home: Scaffold(body: ObjekTab())));
// }
