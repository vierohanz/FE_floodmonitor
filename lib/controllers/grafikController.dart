// mport 'package:flood_monitor/utils/apiService.dart';
// import 'package:flood_monitor/utils/color.dart';
// import 'package:flood_monitor/views/component/grafik/KecepatanAngin.dart';
// import 'package:flutter/material.dart';
// import 'package:flood_monitor/views/component/grafik/CurahHujan.dart';
// import 'package:flood_monitor/views/component/grafik/KetinggianAir.dart';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';

// class GrafikTab extends StatefulWidget {
//   @override
//   _GrafikTabState createState() => _GrafikTabState();
// }

// List<Map<String, dynamic>> getMaxValuesPerDay(List<Map<String, dynamic>> data) {
//   Map<String, Map<String, double>> maxValues = {};

//   for (var entry in data) {
//     final date = DateTime.parse(entry['created_at']).toLocal();
//     final key = '${date.year}-${date.month}-${date.day}';

//     final waterLevel = entry['water_level'] != null
//         ? double.tryParse(entry['water_level']) ?? 0.0
//         : 0.0;

//     final rainfall = entry['rainfall'] != null
//         ? double.tryParse(entry['rainfall']) ?? 0.0
//         : 0.0;

//     final windSpeed = entry['wind_speed'] != null
//         ? double.tryParse(entry['wind_speed']) ?? 0.0
//         : 0.0;

//     if (!maxValues.containsKey(key)) {
//       maxValues[key] = {
//         'water_level': waterLevel,
//         'rainfall': rainfall,
//         'wind_speed': windSpeed,
//       };
//     } else {
//       maxValues[key]!['water_level'] =
//           waterLevel > maxValues[key]!['water_level']!
//               ? waterLevel
//               : maxValues[key]!['water_level']!;
//       maxValues[key]!['rainfall'] = rainfall > maxValues[key]!['rainfall']!
//           ? rainfall
//           : maxValues[key]!['rainfall']!;
//       maxValues[key]!['wind_speed'] = windSpeed > maxValues[key]!['wind_speed']!
//           ? windSpeed
//           : maxValues[key]!['wind_speed']!;
//     }
//   }

//   return maxValues.entries.map((entry) {
//     return {
//       'date': entry.key,
//       'water_level': entry.value['water_level']!.toStringAsFixed(2),
//       'rainfall': entry.value['rainfall']!.toStringAsFixed(2),
//       'wind_speed': entry.value['wind_speed']!.toStringAsFixed(2),
//     };
//   }).toList();
// }

// class _GrafikTabState extends State<GrafikTab> {
//   // Nilai default untuk variabel yang sebelumnya dideklarasikan dengan 'late'
//   int? selectedRegencyId = 0; // Nilai default 0
//   double selectedRegencyLatitude = 0.0; // Nilai default 0.0
//   double selectedRegencyLongitude = 0.0; // Nilai default 0.0
//   String selectedRegencyName = 'unknown'; // Nilai default 'unknown'

//   final List<String> _months = [
//     "Januari",
//     "Februari",
//     "Maret",
//     "April",
//     "Mei",
//     "Juni",
//     "Juli",
//     "Agustus",
//     "September",
//     "Oktober",
//     "November",
//     "Desember",
//   ];

//   // Memuat data dari SharedPreferences
//   _loadSelectedRegency() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       selectedRegencyId = prefs.getInt('selectedRegencyId') ?? 0;
//       selectedRegencyName = prefs.getString('selectedRegencyName') ?? 'unknown';
//       selectedRegencyLatitude =
//           prefs.getDouble('selectedRegencyLatitude') ?? 0.0;
//       selectedRegencyLongitude =
//           prefs.getDouble('selectedRegencyLongitude') ?? 0.0;
//     });
//   }

//   // Widget untuk efek shimmer pada grafik
//   Widget _buildShimmerPlaceholder() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             width: double.infinity,
//             height: 180.0, // Placeholder untuk grafik utama
//             color: Colors.grey,
//           ),
//           SizedBox(height: 8.0),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 16.0),
//             width: double.infinity,
//             height: 180.0, // Placeholder untuk grafik kedua
//             color: Colors.grey,
//           ),
//           SizedBox(height: 8.0),
//         ],
//       ),
//     );
//   }

//   final List<String> _monitoringPoints1 = ["Klego", "Yosorejo"];
//   final List<String> _monitoringPoints2 = ["Kedungwuluh", "Kertabesuki"];
//   List<String> _monitoringPoints = [];
//   final TextEditingController _selectedPointController =
//       TextEditingController();
//   final TextEditingController _selectedMonthController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _selectedPointController.text = _monitoringPoints1[0]; // Default: Klego
//     _selectedMonthController.text = _months[0]; // Default: Januari
//     _loadSelectedRegency();
//   }

//   @override
//   void dispose() {
//     _selectedPointController.dispose();
//     _selectedMonthController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (selectedRegencyId == 1) {
//       _monitoringPoints = _monitoringPoints1;
//     } else if (selectedRegencyId == 2) {
//       _monitoringPoints = _monitoringPoints2;
//     } else {
//       _monitoringPoints = [];
//     }

//     return SingleChildScrollView(
//       controller: ScrollController(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Dropdown untuk memilih bulan
//           Container(
//             padding: EdgeInsets.only(left: 16, top: 16),
//             child: Row(
//               children: [
//                 Text(
//                   "Pilih Bulan: ",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 10),
//                 Container(
//                   child: Expanded(
//                     child: CustomDropdown<String>.search(
//                       hintText: "Pilih Bulan",
//                       items: _months,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedMonthController.text = newValue!;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Dropdown untuk memilih titik pantau
//           Container(
//             padding: EdgeInsets.only(left: 16),
//             child: Row(
//               children: [
//                 Text(
//                   "Titik Pantau: ",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 2),
//                 Expanded(
//                   child: CustomDropdown<String>.search(
//                     hintText: "Pilih Titik Pantau",
//                     items: _monitoringPoints,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedPointController.text = newValue!;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // FutureBuilder untuk grafik
//           FutureBuilder<List<Map<String, dynamic>>>(
//             future: ApiService.fetchDataSensor(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return _buildShimmerPlaceholder(); // Mengganti dengan shimmer
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData) {
//                 final filteredData = snapshot.data!.where((item) {
//                   final deviceName = item['device_name'];
//                   final createdAt = item['created_at'];
//                   final waterLevel = item['water_level'];

//                   if (deviceName == null ||
//                       createdAt == null ||
//                       waterLevel == null) {
//                     return false;
//                   }

//                   final pointMatch =
//                       deviceName.contains(_selectedPointController.text);
//                   final monthIndex =
//                       _months.indexOf(_selectedMonthController.text) + 1;
//                   final createdAtDate = DateTime.parse(createdAt);
//                   final monthMatch = createdAtDate.month == monthIndex;

//                   return pointMatch && monthMatch;
//                 }).toList();

//                 final maxDataPerDay = getMaxValuesPerDay(filteredData);
//                 return Column(
//                   children: [
//                     CurahHujan(data: maxDataPerDay),
//                     SizedBox(height: 3),
//                     KetinggianAir(data: maxDataPerDay),
//                     SizedBox(height: 3),
//                     KecepetanAngin(data: maxDataPerDay),
//                   ],
//                 );
//               } else {
//                 return Center(child: Text('No data available'));
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }