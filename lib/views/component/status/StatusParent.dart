import 'package:flutter/material.dart';
import 'package:flood_monitor/utils/apiService.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_1.dart';
import 'package:flood_monitor/views/component/status/StatusTerakhir_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusParent extends StatefulWidget {
  const StatusParent({super.key});

  @override
  _StatusParentState createState() => _StatusParentState();
}

class _StatusParentState extends State<StatusParent> {
  late int selectedRegencyId;
  late double selectedRegencyLatitude;
  late double selectedRegencyLongitude;
  late String selectedRegencyName;
  late Future<List<Map<String, dynamic>>> _data; // Data yang diterima dari API
  final Map<String, List<int>> deviceIdsByCity = {
    'Pekalongan': [1, 2], // Device_id untuk Pekalongan
    'Brebes': [3, 4], // Device_id untuk Brebes
  };

  @override
  void initState() {
    super.initState();
    _data =
        ApiService.fetchDataSensor(); // Memanggil API untuk mendapatkan data
    _loadSelectedRegency();
  }

  // Memuat data dari SharedPreferences
  _loadSelectedRegency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedRegencyId = prefs.getInt('selectedRegencyId') ?? 0;
      selectedRegencyName = prefs.getString('selectedRegencyName') ?? 'Unknown';
      selectedRegencyLatitude =
          prefs.getDouble('selectedRegencyLatitude') ?? 0.0;
      selectedRegencyLongitude =
          prefs.getDouble('selectedRegencyLongitude') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // FutureBuilder untuk mendapatkan data berdasarkan kota yang dipilih
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  if (selectedRegencyName.isNotEmpty &&
                      selectedRegencyName != 'unknown') {
                    // Gunakan selectedRegencyName untuk memfilter data
                    final cityDeviceIds =
                        deviceIdsByCity[selectedRegencyName] ?? [];
                    final filteredData = snapshot.data!
                        .where(
                            (data) => cityDeviceIds.contains(data['device_id']))
                        .toList();

                    if (filteredData.isNotEmpty) {
                      // Ambil data untuk device_id 1 atau 3 untuk StatusTerakhir1Tab
                      final statusTerakhir1Data = filteredData
                          .where((data) =>
                              data['device_id'] == 1 || data['device_id'] == 3)
                          .last;

                      // Ambil data untuk device_id 2 atau 4 untuk StatusTerakhir2Tab
                      final statusTerakhir2Data = filteredData
                          .where((data) =>
                              data['device_id'] == 2 || data['device_id'] == 4)
                          .last;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            StatusTerakhir1Tab(
                                data:
                                    statusTerakhir1Data), // Mengirim data untuk device_id 1 atau 3
                            StatusTerakhir2Tab(
                                data:
                                    statusTerakhir2Data), // Mengirim data untuk device_id 2 atau 4
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('No data available for this city'),
                      );
                    }
                  } else {
                    // Tampilkan pesan "Pilih kota terlebih dahulu" jika nama kota tidak valid
                    return Center(
                      child: Text(
                        'Pilih kota terlebih dahulu',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
