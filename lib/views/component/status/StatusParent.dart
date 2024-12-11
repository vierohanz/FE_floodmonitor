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
  late Future<List<Map<String, dynamic>>> _data;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _loadCityFromPreferences();
    _data = ApiService.fetchDataSensor();
  }

  // Fungsi untuk memuat kota dari SharedPreferences
  Future<void> _loadCityFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCity = prefs.getString('regency.name') ??
          'Pekalongan'; // Ambil nama kota dari session
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
                  // Filter data berdasarkan kota yang dipilih
                  final filteredData = snapshot.data!
                      .where((data) =>
                          data['regency_name']
                              ?.contains(selectedCity ?? 'Pekalongan') ==
                          true)
                      .toList();

                  if (filteredData.isNotEmpty) {
                    // Ambil data untuk device_id sesuai kota
                    final statusTerakhir1Data = filteredData
                        .where((data) =>
                            data['regency_name'].contains(selectedCity!))
                        .last;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          StatusTerakhir1Tab(data: statusTerakhir1Data),
                          // Tambahkan komponen lainnya jika perlu
                        ],
                      ),
                    );
                  } else {
                    return Center(
                        child: Text('No data available for $selectedCity'));
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
