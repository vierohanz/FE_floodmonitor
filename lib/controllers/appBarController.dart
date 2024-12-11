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
  void updateSelectedValue(String value) {
    selectedValue.value = value;
    final selectedRegency =
        regencies.firstWhere((regency) => regency.name == value);

    // Save all relevant details (id, name, latitude, longitude) to SharedPreferences
    saveSelectedValue(selectedRegency.id, selectedRegency.name,
        selectedRegency.latitude, selectedRegency.longitude);

    // Fetch the full regency details and print them
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

    // Convert latitude and longitude from String to double
    double latitude = double.tryParse(latitudeStr) ?? 0.0;
    double longitude = double.tryParse(longitudeStr) ?? 0.0;

    // Store the values into SharedPreferences
    await prefs.setInt('selectedRegencyId', id);
    await prefs.setString('selectedRegencyName', name);
    await prefs.setDouble('selectedRegencyLatitude', latitude);
    await prefs.setDouble('selectedRegencyLongitude', longitude);

    // Log confirmation message
    print(
        "Saved to SharedPreferences: id = $id, name = $name, latitude = $latitude, longitude = $longitude");
  }

  // Load the selected value from SharedPreferences
  Future<void> loadSelectedValue() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getInt('selectedRegencyId');

    if (savedId != null) {
      final regency = await fetchRegencyDetails(savedId);
      if (regency != null) {
        print("Loaded from SharedPreferences: ");
        print("ID = ${regency.id}");
        print("Name = ${regency.name}");
        print("Latitude = ${regency.latitude}");
        print("Longitude = ${regency.longitude}");
      }
    } else {
      print("No regency ID found in SharedPreferences");
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
    return "${now.day}-${now.month}-${now.year}";
  }
}
