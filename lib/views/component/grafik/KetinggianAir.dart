import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class KetinggianAir extends StatelessWidget {
  final List<Map<String, dynamic>> data; // Data dari API

  const KetinggianAir({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          SizedBox(height: 10),
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue, // Warna header
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              'Ketinggian Air',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Grafik
          data.isEmpty
              ? Center(
                  child: Text(
                    'Data tidak tersedia',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              : AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      // Data untuk garis grafik
                      lineBarsData: [
                        LineChartBarData(
                          spots: data.asMap().entries.map((entry) {
                            final index = entry.key.toDouble();
                            final waterLevel = entry.value['water_level'];
                            if (waterLevel == null || waterLevel.isEmpty) {
                              // Tangani jika 'water_level' null atau kosong
                              return FlSpot(index,
                                  0.0); // Bisa menggunakan nilai default, misal 0.0
                            } else {
                              final waterLevelDouble =
                                  double.tryParse(waterLevel) ??
                                      0.0; // Parsing aman
                              return FlSpot(index, waterLevelDouble);
                            }
                          }).toList(),
                          color: const Color.fromARGB(255, 40, 40, 40),
                          isCurved: false,
                          barWidth: 2,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              if (spot.y < 50) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color.fromARGB(
                                      255, 191, 191, 191), // Hujan ringan
                                  strokeColor:
                                      const Color.fromARGB(255, 177, 177, 177),
                                );
                              }
                              // Logika untuk menentukan warna titik berdasarkan curah hujan
                              else if (spot.y >= 50 && spot.y <= 125) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.green, // Hujan ringan
                                  strokeColor: Colors.greenAccent,
                                );
                              } else if (spot.y > 125 && spot.y <= 175) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color.fromARGB(
                                      255, 251, 230, 37), // Hujan sedang
                                  strokeColor: Colors.yellowAccent,
                                );
                              } else if (spot.y > 175 && spot.y <= 250) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.orange, // Hujan lebat
                                  strokeColor: Colors.orangeAccent,
                                );
                              } else if (spot.y > 250 && spot.y <= 300) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.red, // Hujan sangat lebat
                                  strokeColor: Colors.redAccent,
                                );
                              } else if (spot.y > 300) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color.fromARGB(
                                      255, 195, 0, 255), // Tidak ada kategori
                                  strokeColor: Color.fromARGB(255, 195, 0, 255),
                                );
                              } else {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.grey, // Tidak ada kategori
                                  strokeColor: Colors.grey,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        // Label untuk sumbu X (tanggal)
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < data.length) {
                                final date = data[value.toInt()]
                                    ['date']; // Ambil tanggal yang sudah diolah

                                if (date != null && date.isNotEmpty) {
                                  try {
                                    // Mengubah tanggal dari format 'YYYY-MM-DD' menjadi DateTime
                                    final parsedDate = DateTime.parse(date);
                                    return Text(
                                      '${parsedDate.day}', // Menampilkan hanya hari (misalnya "29")
                                      style: TextStyle(fontSize: 10),
                                    );
                                  } catch (e) {
                                    // Jika parsing gagal, tampilkan 'Invalid'
                                    return Text(
                                      'Invalid',
                                      style: TextStyle(fontSize: 10),
                                    );
                                  }
                                } else {
                                  return Text(
                                    'No Date', // Tampilkan 'No Date' jika tidak ada tanggal
                                    style: TextStyle(fontSize: 10),
                                  );
                                }
                              }
                              return Text('');
                            },
                          ),
                        ),
                        // Label untuk sumbu Y (nilai curah hujan)
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(0),
                                style: TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        // Sumbu kanan dan atas tidak digunakan
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(reservedSize: 10),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(reservedSize: 10),
                        ),
                      ),

                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final waterLevel = spot.y.toStringAsFixed(1);
                              return LineTooltipItem(
                                '$waterLevel cm', // Menambahkan "mm" di nilai tooltip
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        touchCallback:
                            (FlTouchEvent event, LineTouchResponse? response) {
                          // Callback jika Anda ingin menambahkan aksi lain saat titik disentuh
                        },
                        handleBuiltInTouches: true,
                      ),
                      // Grid dan batas grafik
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      minX: 0,
                      maxX: (data.length - 1).toDouble(),
                      minY: 50,
                      maxY:
                          350, // Sesuaikan dengan rentang curah hujan maksimal
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.green,
                        ),
                        SizedBox(width: 5),
                        Text('Normal (50-125 cm)',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 5),
                        Text('Siaga 1 (125-175 cm)',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 5),
                        Text('Siaga 2 (175-250 cm)',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text('Siaga 3 (250> cm)',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
