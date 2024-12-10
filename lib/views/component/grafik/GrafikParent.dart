import 'package:flood_monitor/utils/apiService.dart';
import 'package:flood_monitor/views/component/grafik/KecepatanAngin.dart';
import 'package:flutter/material.dart';
import 'package:flood_monitor/views/component/grafik/CurahHujan.dart';
import 'package:flood_monitor/views/component/grafik/KetinggianAir.dart';

class GrafikTab extends StatefulWidget {
  @override
  _GrafikTabState createState() => _GrafikTabState();
}

List<Map<String, dynamic>> getMaxValuesPerDay(List<Map<String, dynamic>> data) {
  Map<String, Map<String, double>> maxValues = {};

  for (var entry in data) {
    final date = DateTime.parse(entry['created_at']).toLocal();
    final key = '${date.year}-${date.month}-${date.day}'; // Format YYYY-MM-DD

    // Pastikan nilai 'water_level', 'rainfall', dan 'wind_speed' tidak null atau kosong
    final waterLevel = entry['water_level'] != null
        ? double.tryParse(entry['water_level']) ?? 0.0
        : 0.0; // Jika null, beri nilai default 0.0

    final rainfall = entry['rainfall'] != null
        ? double.tryParse(entry['rainfall']) ?? 0.0
        : 0.0;

    final windSpeed = entry['wind_speed'] != null
        ? double.tryParse(entry['wind_speed']) ?? 0.0
        : 0.0;

    // Menyimpan nilai maksimal untuk water_level, rainfall, dan wind_speed
    if (!maxValues.containsKey(key)) {
      maxValues[key] = {
        'water_level': waterLevel,
        'rainfall': rainfall,
        'wind_speed': windSpeed,
      };
    } else {
      maxValues[key]!['water_level'] =
          waterLevel > maxValues[key]!['water_level']!
              ? waterLevel
              : maxValues[key]!['water_level']!;
      maxValues[key]!['rainfall'] = rainfall > maxValues[key]!['rainfall']!
          ? rainfall
          : maxValues[key]!['rainfall']!;
      maxValues[key]!['wind_speed'] = windSpeed > maxValues[key]!['wind_speed']!
          ? windSpeed
          : maxValues[key]!['wind_speed']!;
    }
  }

  // Konversi hasil ke dalam format yang sesuai
  return maxValues.entries.map((entry) {
    return {
      'date': entry.key,
      'water_level':
          entry.value['water_level']!.toStringAsFixed(2), // Format desimal 2
      'rainfall': entry.value['rainfall']!.toStringAsFixed(2),
      'wind_speed': entry.value['wind_speed']!.toStringAsFixed(2),
    };
  }).toList();
}

class _GrafikTabState extends State<GrafikTab> {
  final List<String> _months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  final List<String> _monitoringPoints = ["Klego", "Yosorejo"];
  String _selectedPoint = "Klego";
  String _selectedMonth = "Januari";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown untuk memilih bulan
          Container(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Pilih Bulan: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedMonth,
                  items: _months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMonth = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          // Dropdown untuk memilih titik pantau
          Container(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Row(
              children: [
                Text(
                  "Titik Pantau: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedPoint,
                  items: _monitoringPoints.map((String point) {
                    return DropdownMenuItem<String>(
                      value: point,
                      child: Text(point),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPoint = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          // FutureBuilder untuk grafik
          FutureBuilder<List<Map<String, dynamic>>>(
            future: ApiService.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // Filter data berdasarkan titik pantau dan bulan
                final filteredData = snapshot.data!.where((item) {
                  // Pastikan semua nilai yang diperlukan tidak null
                  final deviceName = item['device_name'];
                  final createdAt = item['created_at'];
                  final waterLevel = item['water_level'];

                  if (deviceName == null ||
                      createdAt == null ||
                      waterLevel == null) {
                    return false; // Jika ada nilai null, data ini akan diabaikan
                  }

                  final pointMatch = deviceName.contains(_selectedPoint);
                  final monthIndex = _months.indexOf(_selectedMonth) + 1;
                  final createdAtDate = DateTime.parse(createdAt);
                  final monthMatch = createdAtDate.month == monthIndex;

                  return pointMatch && monthMatch;
                }).toList();

                // Ambil nilai maksimal per hari
                final maxDataPerDay = getMaxValuesPerDay(filteredData);
                return Column(
                  children: [
                    CurahHujan(data: maxDataPerDay),
                    SizedBox(height: 3),
                    KetinggianAir(data: maxDataPerDay),
                    SizedBox(height: 3),
                    KecepetanAngin(data: maxDataPerDay),
                  ],
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),
    );
  }
}
