import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flood_monitor/utils/apiService.dart';

class StatusController {
  late Future<List<Map<String, dynamic>>> data;
  final ValueNotifier<Map<String, dynamic>> regencyNotifier;
  Timer? _updateTimer;

  final Map<String, List<int>> deviceIdsByCity = {
    'Pekalongan': [1, 2], // Device_id untuk Pekalongan
    'Brebes': [3, 4], // Device_id untuk Brebes
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
  }

  // Mulai mendengarkan perubahan pada SharedPreferences
  void _startListeningToPreferences() {
    _updateTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _loadSelectedRegency();
    });
  }

  // Muat data regency dari SharedPreferences dan perbarui regencyNotifier
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

    // Update hanya jika ada perubahan pada nilai
    if (regencyNotifier.value != newRegencyData) {
      regencyNotifier.value = newRegencyData;
    }
  }

  // Ambil data sensor yang sudah difilter
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

  // Ambil data spesifik berdasarkan device_id
  Map<String, dynamic>? getStatusData(
      List<Map<String, dynamic>> filteredData, List<int> deviceIds) {
    return filteredData
        .where((data) => deviceIds.contains(data['device_id']))
        .lastOrNull;
  }

  // Membersihkan timer saat controller tidak digunakan lagi
  void dispose() {
    _updateTimer?.cancel();
  }
}

extension LastOrNull<E> on Iterable<E> {
  E? get lastOrNull => isEmpty ? null : last;
}
