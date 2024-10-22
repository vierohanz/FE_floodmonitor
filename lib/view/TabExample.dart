import 'package:fl_chart/fl_chart.dart';
import 'package:flood_monitor/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTabExample extends StatelessWidget {
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
                  color: kprimarySecond,
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
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kprimarySecond,
            ),
            child: Text(
              'Curah Hujan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, .83), // Titik pertama
                      FlSpot(1, .84), // Titik kedua
                      FlSpot(2, .82), // Titik ketiga
                      FlSpot(3, .83), // Titik keempat
                      FlSpot(4, .84), // Titik kelima
                      FlSpot(5, .95), // Titik keenam
                      FlSpot(6, .86), // Titik ketujuh
                      FlSpot(7, .87), // Titik kedelapan
                      FlSpot(8, .88), // Titik kesembilan
                    ],
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      Colors.red,
                      Colors.purpleAccent,
                      Colors.lightBlueAccent
                    ]),
                    isCurved: false, // Garis lurus
                    barWidth: 1, // Lebar garis
                    // dotData: FlDotData(show: true), // Tampilkan titik
                  ),
                ],
                titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('24');
                            case 1:
                              return Text('25');
                            case 2:
                              return Text('26');
                            case 3:
                              return Text('27');
                            case 4:
                              return Text('28');
                            case 5:
                              return Text('29');
                            case 6:
                              return Text('30');
                            case 7:
                              return Text('31');
                            case 8:
                              return Text('01');
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toStringAsFixed(2));
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        // showTitles:
                        //     false, // Menyembunyikan label di sebelah kanan (Y-axis)
                        reservedSize: 10,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        // showTitles:
                        //     false, // Menyembunyikan label di sebelah kanan (Y-axis)
                        reservedSize: 10,
                      ),
                    )),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                minX: 0,
                maxX: 8,
                minY: 0.80,
                maxY: 0.95,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(CustomTabExample());
}
