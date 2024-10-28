import 'package:flood_monitor/views/component/grafik/GrafikParent.dart';
import 'package:flood_monitor/views/component/status/StatusParent.dart';
import 'package:flutter/material.dart';

class ObjekTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Warna background
        body: Column(
          children: [
            // TabBar tanpa AppBar
            Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              // ),
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
            // TabBarView untuk konten masing-masing tab
            Expanded(
              child: TabBarView(
                children: [
                  StatusParent(), // Konten untuk tab Status Terakhir
                  GrafikTab(), // Konten untuk tab Grafik
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(ObjekTab());
}
