import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flood_monitor/utils/apiService.dart';

class StatusController extends GetxController {
  late Future<List<Map<String, dynamic>>> data;
  final ValueNotifier<Map<String, dynamic>> regencyNotifier;
  Timer? _updateTimer;
  Timer? _comparisonTimer;

  final Map<String, List<int>> deviceIdsByCity = {
    'Pekalongan': [1, 2],
    'Brebes': [3, 4],
  };

  StatusController()
      : regencyNotifier = ValueNotifier<Map<String, dynamic>>({
          'selectedRegencyId': 0,
          'selectedRegencyName': 'Unknown',
          'selectedRegencyLatitude': 0.0,
          'selectedRegencyLongitude': 0.0,
        }) {
    data = ApiService.fetchDataSensor();
    _startListeningToPreferences();
    _startPeriodicComparisonUpdate();
  }

  // Start listening to changes on SharedPreferences
  void _startListeningToPreferences() {
    _updateTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _loadSelectedRegency();
    });
  }

  // Load regency data from SharedPreferences and update regencyNotifier
  Future<void> _loadSelectedRegency() async {
    final prefs = await SharedPreferences.getInstance();
    final newRegencyData = {
      'selectedRegencyId': prefs.getInt('selectedRegencyId') ?? 0,
      'selectedRegencyName':
          prefs.getString('selectedRegencyName') ?? 'Unknown',
      'selectedRegencyLatitude':
          prefs.getDouble('selectedRegencyLatitude') ?? 0.0,
      'selectedRegencyLongitude':
          prefs.getDouble('selectedRegencyLongitude') ?? 0.0,
    };

    // Update only if there is a change in the values
    if (!mapEquals(regencyNotifier.value, newRegencyData)) {
      regencyNotifier.value = newRegencyData;
    }
  }

  // Fetch filtered sensor data based on the selected regency
  Future<List<Map<String, dynamic>>> getFilteredData() async {
    final fetchedData = await data;
    final selectedRegencyName = regencyNotifier.value['selectedRegencyName'];
    if (selectedRegencyName.isNotEmpty &&
        selectedRegencyName.toLowerCase() != 'unknown') {
      final cityDeviceIds = deviceIdsByCity[selectedRegencyName] ?? [];
      return fetchedData
          .where((data) => cityDeviceIds.contains(data['device_id']))
          .toList();
    }
    return [];
  }

  // Get specific status data based on device_id
  Map<String, dynamic>? getStatusData(
      List<Map<String, dynamic>> filteredData, List<int> deviceIds) {
    return filteredData
        .where((data) => deviceIds.contains(data['device_id']))
        .lastOrNull;
  }

  // Get the comparison result based on the filtered data and device ids
  String getComparisonResult(List<Map<String, dynamic>> filteredData) {
    final statusTerakhir1Data = getStatusData(filteredData, [1, 3]);
    final statusTerakhir2Data = getStatusData(filteredData, [2, 4]);

    String result;

    // Extracting status and device_name
    String status1 = statusTerakhir1Data?['status'] ?? 'NA';
    String deviceName1 =
        statusTerakhir1Data?['device_name'] ?? 'Unknown Device';

    String status2 = statusTerakhir2Data?['status'] ?? 'NA';
    String deviceName2 =
        statusTerakhir2Data?['device_name'] ?? 'Unknown Device';

    // Print device names and their statuses
    print('Device 1: $deviceName1');
    print('Status 1: $status1');
    print('Device 2: $deviceName2');
    print('Status 2: $status2');

    if (status1.toLowerCase() == 'banjir' ||
        status2.toLowerCase() == 'banjir') {
      result = 'Banjir';
    } else if (status1.toLowerCase() == 'tidak banjir' &&
        status2.toLowerCase() == 'tidak banjir') {
      result = 'Tidak Banjir';
    } else if (status1 == 'NA' && status2 == 'NA') {
      result = 'N/A';
    } else if (status1.toLowerCase() == 'tidak banjir' &&
        status2.toLowerCase() == 'NA') {
      result = 'Tidak Banjir';
    } else if (status1.toLowerCase() == 'banjir' &&
        status2.toLowerCase() == 'NA') {
      result = 'Tidak Banjir';
    } else if (status1.toLowerCase() == 'NA' &&
        status2.toLowerCase() == 'tidak banjir') {
      result = 'Tidak Banjir';
    } else {
      result = 'Banjir';
    }

    return result;
  }

  // Start periodically checking the comparison result
  void _startPeriodicComparisonUpdate() {
    _comparisonTimer = Timer.periodic(Duration(seconds: 5), (_) async {
      final filteredData = await getFilteredData();
      final result = getComparisonResult(filteredData);
      print('Comparison Result: $result');
      // Handle any UI updates or notifications here based on the result
    });
  }

  // Clean up the timers when the controller is no longer needed
  @override
  void onClose() {
    _updateTimer?.cancel();
    _comparisonTimer?.cancel();
    super.onClose();
  }
}

// Extension to get last item or null
extension LastOrNull<E> on Iterable<E> {
  E? get lastOrNull => isEmpty ? null : last;
}

// Helper function to compare maps
bool mapEquals(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  if (map1.length != map2.length) return false;
  for (var key in map1.keys) {
    if (map1[key] != map2[key]) return false;
  }
  return true;
}
