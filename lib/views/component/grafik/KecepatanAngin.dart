import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class KecepetanAngin extends StatelessWidget {
  final List<Map<String, dynamic>> data; // Data dari API

  const KecepetanAngin({required this.data, super.key});

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
              'Kecepatan Angin',
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
                            final wind_speed = entry.value['wind_speed'];
                            if (wind_speed == null || wind_speed.isEmpty) {
                              // Tangani jika 'water_level' null atau kosong
                              return FlSpot(index,
                                  0.0); // Bisa menggunakan nilai default, misal 0.0
                            } else {
                              final wind_speedDouble =
                                  double.tryParse(wind_speed) ??
                                      0.0; // Parsing aman
                              return FlSpot(index, wind_speedDouble);
                            }
                          }).toList(),
                          color: const Color.fromARGB(255, 52, 136, 255),
                          isCurved: false,
                          barWidth: 2,
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
                      // Grid dan batas grafik
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      minX: 0,
                      maxX: (data.length - 1).toDouble(),
                      minY: 0,
                      maxY: 40, // Sesuaikan dengan rentang curah hujan maksimal
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
