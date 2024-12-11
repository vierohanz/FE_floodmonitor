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
    int? selectedRegencyId =
        regencies.firstWhere((regency) => regency.name == value).id;
    saveSelectedValue(selectedRegencyId);
    fetchRegencyDetails(selectedRegencyId!).then((regency) {
      if (regency != null) {
        print("Selected Regency Details:");
        print("ID: ${regency.id}");
        print("Name: ${regency.name}");
        print("Latitude: ${regency.latitude}");
        print("Longitude: ${regency.longitude}");
      }
    });
  }

  // Save selected value (ID) to SharedPreferences
  Future<void> saveSelectedValue(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id != null) {
      await prefs.setInt('selectedRegencyId', id);
      print("Saved to SharedPreferences: selectedRegencyId = $id");
    }
  }

  // Load the selected value from SharedPreferences
  Future<void> loadSelectedValue([int? id]) async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = id ?? prefs.getInt('selectedRegencyId');

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
