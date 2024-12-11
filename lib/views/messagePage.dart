import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flood_monitor/views/component/broadcast/ListBroadcast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class messagePage extends StatefulWidget {
  const messagePage({Key? key}) : super(key: key);

  @override
  _messagePageState createState() => _messagePageState();
}

class _messagePageState extends State<messagePage> {
  late int selectedDeviceId = 0; // Default untuk semua data
  late int selectedRegencyId;
  late double selectedRegencyLatitude;
  late double selectedRegencyLongitude;
  late String selectedRegencyName;
  final List<String> _monitoringPoints1 = ["Klego", "Yosorejo"];
  final List<String> _monitoringPoints2 = ["Kedungwuluh", "Kertabesuki"];
  late List<String> _monitoringPoints;
  final TextEditingController _selectedPointController =
      TextEditingController();

  // Memuat data dari SharedPreferences
  _loadSelectedRegency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedRegencyId = prefs.getInt('selectedRegencyId') ?? 0;
      selectedRegencyName =
          prefs.getString('selectedRegencyName') ?? 'Pekalongan';
      selectedRegencyLatitude =
          prefs.getDouble('selectedRegencyLatitude') ?? 0.0;
      selectedRegencyLongitude =
          prefs.getDouble('selectedRegencyLongitude') ?? 0.0;
    });
  }

  @override
  void initState() {
    super.initState();
    // Gabungkan dua daftar menjadi satu daftar yang dapat digunakan
    _monitoringPoints = [..._monitoringPoints1, ..._monitoringPoints2];
    _loadSelectedRegency();
  }

  @override
  void dispose() {
    _selectedPointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;

    if (selectedRegencyId == 1) {
      _monitoringPoints = _monitoringPoints1;
    } else if (selectedRegencyId == 2) {
      _monitoringPoints = _monitoringPoints2;
    } else {
      _monitoringPoints = []; // Kosongkan jika ID tidak cocok
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEBF0F7),
      body: SingleChildScrollView(
        child: Container(
          width: wp,
          padding:
              const EdgeInsets.only(top: 12, right: 22, left: 22, bottom: 10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: hp * 0.02),
                child: Column(
                  children: [
                    Container(
                      width: wp,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          topRight: Radius.circular(13),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daftar Broadcast",
                            style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: "NunitoSans",
                              fontSize: wp * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              print("Tombol tambah ditekan");
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding:
                          const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Titik Pantau: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomDropdown<String>.search(
                              hintText: "Pilih Titik Pantau",
                              items: _monitoringPoints,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedPointController.text = newValue;
                                    // Mapping nama titik pantau ke device_id
                                    selectedDeviceId = _monitoringPoints1
                                            .contains(newValue)
                                        ? _monitoringPoints1.indexOf(newValue) +
                                            1
                                        : _monitoringPoints2.indexOf(newValue) +
                                            3;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      width: wp,
                      height: hp * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Listbroadcast(
                        selectedDeviceId: selectedDeviceId,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
