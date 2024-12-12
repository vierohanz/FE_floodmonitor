import 'dart:convert';
import 'package:flood_monitor/apiConfig.dart';
import 'package:flood_monitor/models/getAllRegencyModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class appBarController extends GetxController {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  var isRotated = false.obs;
  var regencies = <getAllRegencyModel>[].obs;
  var isLoading = false.obs;
  var selectedValue = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchRegencies().then((_) {
      loadSelectedValue();
    });
  }

// Fetch regencies from API
  Future<void> fetchRegencies() async {
    try {
      isLoading.value = true;
      const String baseUrl = "${prodUrl}/regencies";
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        regencies.value = responseData
            .map((json) => getAllRegencyModel.fromJson(json))
            .toList()
            .cast<getAllRegencyModel>();
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch regencies',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

// Update selected value (id) and fetch regency details
  void updateSelectedValue(String? value) {
    if (value == null || value.isEmpty) {
      // Set default value
      selectedValue.value = null;
      saveSelectedValue(0, "unknown", "0.0", "0.0");
      print("Default values set: ID = 0, Name = unknown");
      return;
    }
    final selectedRegency =
        regencies.firstWhere((regency) => regency.name == value);
    selectedValue.value = value;
    saveSelectedValue(selectedRegency.id, selectedRegency.name,
        selectedRegency.latitude, selectedRegency.longitude);
    fetchRegencyDetails(selectedRegency.id).then((regency) {
      if (regency != null) {
        print("Selected Regency Details:");
        print("ID: ${regency.id}");
        print("Name: ${regency.name}");
        print("Latitude: ${regency.latitude}");
        print("Longitude: ${regency.longitude}");
      }
    });
  }

// Save selected value (ID, Name, Latitude, Longitude) to SharedPreferences
  Future<void> saveSelectedValue(
      int id, String name, String latitudeStr, String longitudeStr) async {
    final prefs = await SharedPreferences.getInstance();

    double latitude = double.tryParse(latitudeStr) ?? 0.0;
    double longitude = double.tryParse(longitudeStr) ?? 0.0;

    await prefs.setInt('selectedRegencyId', id);
    await prefs.setString('selectedRegencyName', name);
    await prefs.setDouble('selectedRegencyLatitude', latitude);
    await prefs.setDouble('selectedRegencyLongitude', longitude);
    print(
        "Saved to SharedPreferences: id = $id, name = $name, latitude = $latitude, longitude = $longitude");
  }

// Load the selected value from SharedPreferences
  Future<void> loadSelectedValue() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('selectedRegencyId')) {
      await prefs.setInt('selectedRegencyId', 0);
    }
    if (!prefs.containsKey('selectedRegencyName')) {
      await prefs.setString('selectedRegencyName', "unknown");
    }
    if (!prefs.containsKey('selectedRegencyLatitude')) {
      await prefs.setDouble('selectedRegencyLatitude', 0.0);
    }
    if (!prefs.containsKey('selectedRegencyLongitude')) {
      await prefs.setDouble('selectedRegencyLongitude', 0.0);
    }

    final savedId = prefs.getInt('selectedRegencyId') ?? 0;
    final savedName = prefs.getString('selectedRegencyName') ?? "unknown";

    if (savedId == 0 || savedName == "unknown") {
      print("No regency selected. Defaulting to ID = 0, Name = unknown.");
      selectedValue.value = null;
      return;
    }

    final regency = await fetchRegencyDetails(savedId);
    if (regency != null) {
      print("Loaded from SharedPreferences:");
      print("ID = null");
      print("Name = Unknown");
      print("Latitude = null");
      print("Longitude = null");
      selectedValue.value = regency.name;
    } else {
      print("No details found for regency with ID \$savedId.");
      selectedValue.value = null;
    }
  }

// Fetch the regency details by ID
  Future<getAllRegencyModel?> fetchRegencyDetails(int id) async {
    try {
      final String url = "${prodUrl}/regencies/$id";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return getAllRegencyModel.fromJson(responseData);
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch regency details',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

// Format the current date
  String getFormattedDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}";
  }
}
