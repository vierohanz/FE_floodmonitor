import 'dart:async';
import 'package:flood_monitor/models/mapModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mapController extends GetxController {
  var selectedValue = RxnString();
  var mapData = mapModel(nameLocation: [], pointLocation: []).obs;
  GoogleMapController? googleMapController;
  late ValueNotifier<Map<String, dynamic>> regencyNotifier;
  Timer? _updateTimer;

  @override
  void onInit() {
    super.onInit();
    _startListeningToPreferences();
    regencyNotifier = ValueNotifier<Map<String, dynamic>>({
      'selectedRegencyId': 0,
      'selectedRegencyName': 'Unknown',
      'selectedRegencyLatitude': 0.0,
      'selectedRegencyLongitude': 0.0,
    });

    _loadSelectedRegency();
    loadSelectedValue();
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _loadSelectedRegency();
      loadSelectedValue();
    });
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

// Listen to preference changes
  Future<void> _startListeningToPreferences() async {
    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _loadSelectedRegency();
      loadSelectedValue();
    });
  }

// Load selected value from shared preferences
  Future<void> loadSelectedValue() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getInt('selectedRegencyId') ?? 0;
    final savedName = prefs.getString('selectedRegencyName') ?? "unknown";
    final savedLatitude = prefs.getDouble('selectedRegencyLatitude') ?? 0.0;
    final savedLongitude = prefs.getDouble('selectedRegencyLongitude') ?? 0.0;

    // Skip if the name has not changed
    if (selectedValue.value == savedName) {
      return;
    }
    LatLng point = LatLng(savedLatitude, savedLongitude);
    mapData.update((data) {
      data?.nameLocation = [savedName];
      data?.pointLocation = [point];
    });

    selectedValue.value = savedName;
    if (googleMapController != null) {
      googleMapController!.animateCamera(
        CameraUpdate.newLatLngZoom(point, 12.0),
      );
    }
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
    }
  }

  // Set the Google Map Controller
  void setGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;
  }
}
