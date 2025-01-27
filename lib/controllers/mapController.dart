import 'dart:async';
import 'dart:convert';
import 'package:flood_monitor/models/mapModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class mapController extends GetxController {
  var selectedValue = RxnString();
  var mapData = mapModel(nameLocation: [], pointLocation: []).obs;
  GoogleMapController? googleMapController;
  late ValueNotifier<Map<String, dynamic>> regencyNotifier;
  Timer? _updateTimer;
  bool isFirstTimeSwitchingCity =
      true; // Flag untuk memeriksa apakah ini pertama kali pindah kota

  @override
  void onInit() {
    super.onInit();
    regencyNotifier = ValueNotifier<Map<String, dynamic>>({
      'selectedRegencyId': 0,
      'selectedRegencyName': 'Unknown',
      'selectedRegencyLatitude': 0.0,
      'selectedRegencyLongitude': 0.0,
    });

    _loadSelectedRegency();
    loadMapData();
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _loadSelectedRegency();
      loadMapData();
    });
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  // Load map data from API using regency ID from shared preferences
  Future<void> loadMapData() async {
    final prefs = await SharedPreferences.getInstance();
    final regencyId = prefs.getInt('selectedRegencyId') ?? 0;

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.cerdaspantaubanjir.my.id/devices?regency=$regencyId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> devices = json.decode(response.body);

        if (devices.isNotEmpty) {
          List<String> names = [];
          List<LatLng> points = [];

          for (var device in devices) {
            final name = device['device_name'] ?? 'Unknown';
            final latitude =
                double.tryParse(device['latitude'] ?? '0.0') ?? 0.0;
            final longitude =
                double.tryParse(device['longitude'] ?? '0.0') ?? 0.0;

            names.add(name);
            points.add(LatLng(latitude, longitude));
          }

          mapData.update((data) {
            data?.nameLocation = names;
            data?.pointLocation = points;
          });

          if (points.isNotEmpty) {
            selectedValue.value = names.first;

            if (isFirstTimeSwitchingCity) {
              if (googleMapController != null) {
                // Hanya geser kamera saat pertama kali pindah kota
                googleMapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(points.first, 16.0),
                );
              }
              isFirstTimeSwitchingCity =
                  false; // Tandai bahwa kota sudah dipindahkan
            } else {
              // Jangan geser kamera jika sudah dipindahkan sebelumnya
              // LatLngBounds bounds = _calculateBounds(points);
              // if (googleMapController != null) {
              //   googleMapController!.animateCamera(
              //     CameraUpdate.newLatLngBounds(bounds, 50),
              //   );
              // }
            }
          }
        }
      } else {
        print('Failed to load devices: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching devices: $e');
    }
  }

  // Calculate LatLngBounds for multiple points
  LatLngBounds _calculateBounds(List<LatLng> points) {
    double south = points.first.latitude;
    double north = points.first.latitude;
    double west = points.first.longitude;
    double east = points.first.longitude;

    for (LatLng point in points) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  // Fetch and update regency data from shared preferences
  _loadSelectedRegency() async {
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
    if (newRegencyData['selectedRegencyId'] !=
            regencyNotifier.value['selectedRegencyId'] ||
        newRegencyData['selectedRegencyName'] !=
            regencyNotifier.value['selectedRegencyName'] ||
        newRegencyData['selectedRegencyLatitude'] !=
            regencyNotifier.value['selectedRegencyLatitude'] ||
        newRegencyData['selectedRegencyLongitude'] !=
            regencyNotifier.value['selectedRegencyLongitude']) {
      regencyNotifier.value = newRegencyData;
      isFirstTimeSwitchingCity = true; // Reset flag ketika kota berubah
    }
  }

  // Set the Google Map Controller
  void setGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;
  }
}
