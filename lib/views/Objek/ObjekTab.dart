import 'package:fl_chart/fl_chart.dart';
import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/views/Objek/ObjekGrafik/CurahHujan.dart';
import 'package:flood_monitor/views/Objek/ObjekGrafik/KetinggianAir.dart';
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(160), // Tumpulkan TabBar
              ),
              child: TabBar(
                labelColor: const Color.fromARGB(
                    255, 0, 0, 0), // Warna teks saat tab aktif

                unselectedLabelColor:
                    Colors.black, // Warna teks saat tab tidak aktif
                indicatorColor: const Color.fromARGB(
                    255, 0, 132, 255), // Warna indikator tab
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
                  StatusTerakhirTab(), // Konten untuk tab Status Terakhir
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

class StatusTerakhirTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8), // Beri padding agar tampilan lebih rapi
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10), // Jarak antar ListTile
            child: ListTile(
              title: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), // Sudut kiri atas tumpul
                    topRight: Radius.circular(3), // Sudut kanan atas tumpul
                    bottomLeft: Radius.circular(0), // Sudut kiri bawah tajam
                    bottomRight: Radius.circular(0), // Sudut kanan bawah tajam
                  ),
                ),
                child: Text(
                  'Titik Pantau Klego (02-Okt-2024 14:00)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                    top:
                        10), // Menambahkan jarak vertikal antara title dan subtitle
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/example.png', // Gambar yang ingin ditampilkan
                      width: 100, // Lebar gambar
                      height: 100, // Tinggi gambar
                    ),
                    SizedBox(width: 10), // Jarak antara teks dan gambar
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Membuat teks rata kiri
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Pisahkan label dan nilai
                            children: [
                              Text(
                                'Status:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  // Beri cetak tebal pada label
                                ),
                              ),
                              Text(
                                'Siaga',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 103, 14),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5), // Memberi jarak antara baris
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Pisahkan label dan nilai
                            children: [
                              Text(
                                'Ketinggian Air:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '120 cm',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 202, 27, 27),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Pisahkan label dan nilai
                            children: [
                              Text(
                                'Curah Hujan:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '5 mm',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 46, 185, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Pisahkan label dan nilai
                            children: [
                              Text(
                                'Kecepatan Angin:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '7 km/h',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 46, 185, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

void main() {
  runApp(ObjekTab());
}
