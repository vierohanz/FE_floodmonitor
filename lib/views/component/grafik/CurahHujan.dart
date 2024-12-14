import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CurahHujan extends StatelessWidget {
  final List<Map<String, dynamic>> data; // Data dari API

  const CurahHujan({required this.data, super.key});

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
              'Curah Hujan',
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
                            final rainfall =
                                double.tryParse(entry.value['rainfall']) ?? 0.0;
                            return FlSpot(index, rainfall);
                          }).toList(),
                          color: const Color.fromARGB(255, 40, 40, 40),
                          isCurved: false,
                          barWidth: 2,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              // Logika untuk menentukan warna titik berdasarkan curah hujan
                              if (spot.y >= 0.5 && spot.y <= 20) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.green, // Hujan ringan
                                  strokeColor: Colors.greenAccent,
                                );
                              } else if (spot.y > 20 && spot.y <= 50) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color.fromARGB(
                                      255, 251, 230, 37), // Hujan sedang
                                  strokeColor: Colors.yellowAccent,
                                );
                              } else if (spot.y > 50 && spot.y <= 100) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.orange, // Hujan lebat
                                  strokeColor: Colors.orangeAccent,
                                );
                              } else if (spot.y > 100 && spot.y <= 150) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: Colors.red, // Hujan sangat lebat
                                  strokeColor: Colors.redAccent,
                                );
                              } else if (spot.y > 150) {
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
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < data.length) {
                                final date = data[value.toInt()]['date'];
                                if (date != null && date.isNotEmpty) {
                                  try {
                                    final parsedDate = DateTime.parse(date);
                                    return Text(
                                      '${parsedDate.day}',
                                      style: TextStyle(fontSize: 10),
                                    );
                                  } catch (e) {
                                    return Text(
                                      'Invalid',
                                      style: TextStyle(fontSize: 10),
                                    );
                                  }
                                } else {
                                  return Text(
                                    'No Date',
                                    style: TextStyle(fontSize: 10),
                                  );
                                }
                              }
                              return Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toStringAsFixed(0)}',
                                style: TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(reservedSize: 10),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(reservedSize: 10),
                        ),
                      ),
                      // Menambahkan interaksi pada grafik
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final rainfall = spot.y.toStringAsFixed(1);
                              return LineTooltipItem(
                                '$rainfall mm',
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
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      minX: 0,
                      maxX: (data.length - 1).toDouble(),
                      minY: 0,
                      maxY: 200,
                    ),
                  ),
                ),
          // Informasi mengenai warna
          SizedBox(height: 10),
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
                        Text('Ringan (0.5-20 mm/hari)',
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
                        Text('Sedang (20-50 mm/hari)',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 10,
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
                        Text('Lebat (50-100 mm/hari)',
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
                        Text('Sangat Lebat (100-150 mm/hari)',
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
