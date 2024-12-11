import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class messagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<messagePage> {
  late int selectedRegencyId;
  late double selectedRegencyLatitude;
  late double selectedRegencyLongitude;
  late String selectedRegencyName;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        title: Text("Message Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selected Regency Details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("ID: $selectedRegencyId"),
            Text("Name: $selectedRegencyName"),
            Text("Latitude: $selectedRegencyLatitude"),
            Text("Longitude: $selectedRegencyLongitude"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Menampilkan data dari SharedPreferences atau menyegarkan data
                _loadSelectedRegency();
              },
              child: Text("Refresh Data"),
            ),
          ],
        ),
      ),
    );
  }
}
