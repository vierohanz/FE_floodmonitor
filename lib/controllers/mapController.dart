import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mapModel.dart';

class mapController extends GetxController {
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> markers = {};

  var savedLatitude = 0.0.obs;
  var savedLongitude = 0.0.obs;
  var currentLocation = ''.obs; // To keep track of selected location name

  final mapM = mapModel(
    nameLocation: ["Polines", "Pekalongan", "Brebes"],
    imgLocation: [
      "assets/images/polines_cover.jpeg",
      "assets/images/pekalongan.jpg",
      "assets/images/brebes.jpg",
    ],
  );

  @override
  void onInit() {
    super.onInit();
    loadSavedLocation();
    loadMarkers();
  }

  // Fetch saved latitude and longitude from SharedPreferences
  Future<void> loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    // Mengambil nilai latitude dan longitude yang tersimpan berdasarkan nama lokasi
    String? locationName = prefs.getString('selectedLocationName');
    if (locationName != null) {
      currentLocation.value = locationName;

      // Mengambil nilai latitude dan longitude dari SharedPreferences berdasarkan lokasi
      savedLatitude.value = prefs.getDouble('${locationName}_Latitude') ?? 0.0;
      savedLongitude.value =
          prefs.getDouble('${locationName}_Longitude') ?? 0.0;

      // Menambahkan log untuk memeriksa apakah data berhasil diambil
      print('Saved Latitude: ${savedLatitude.value}');
      print('Saved Longitude: ${savedLongitude.value}');
    }

    // Menambahkan marker untuk lokasi yang disimpan
    if (savedLatitude.value != 0.0 && savedLongitude.value != 0.0) {
      addSavedLocationMarker();
    }
  }

  // Update map position based on selected location (e.g. Pekalongan)
  Future<void> updateLocation(String locationName) async {
    final prefs = await SharedPreferences.getInstance();

    // Simpan nama lokasi yang dipilih
    prefs.setString('selectedLocationName', locationName);

    // Ambil latitude dan longitude berdasarkan lokasi yang dipilih
    savedLatitude.value = prefs.getDouble('${locationName}_Latitude') ?? 0.0;
    savedLongitude.value = prefs.getDouble('${locationName}_Longitude') ?? 0.0;

    // Update currentLocation
    currentLocation.value = locationName;

    // Update map and marker position
    update();
  }

  // Add marker for saved location
  void addSavedLocationMarker() {
    if (savedLatitude.value != 0.0 && savedLongitude.value != 0.0) {
      markers.add(
        Marker(
          markerId: MarkerId('savedLocation'),
          position: LatLng(savedLatitude.value, savedLongitude.value),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              _buildInfoWindowContent(),
              LatLng(savedLatitude.value, savedLongitude.value),
            );
          },
        ),
      );
      update();
    }
  }

  void loadMarkers() {
    for (int i = 0; i < mapM.nameLocation.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(
              0.0, 0.0), // Placeholder, will update based on shared preferences
          onTap: () {
            if (customInfoWindowController.addInfoWindow != null) {
              customInfoWindowController.addInfoWindow!(
                _buildInfoWindowContent(i),
                LatLng(0.0,
                    0.0), // Placeholder, will update based on shared preferences
              );
            } else {
              print("addInfoWindow is null");
            }
          },
        ),
      );
    }
    update();
  }

  Widget _buildInfoWindowContent([int? index]) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mapM.imgLocation[index ?? 0].startsWith('assets/'))
            Image.asset(
              mapM.imgLocation[index ?? 0],
              height: 100,
              width: 250,
              fit: BoxFit.cover,
            )
          else
            Image.network(
              mapM.imgLocation[index ?? 0],
              height: 100,
              width: 250,
              fit: BoxFit.cover,
            ),
          Container(
            padding: EdgeInsets.all(4),
            child: Text(
              mapM.nameLocation[index ?? 0],
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 6),
                Icon(Icons.star, color: Colors.amber, size: 6),
                Icon(Icons.star, color: Colors.amber, size: 6),
                Icon(Icons.star, color: Colors.amber, size: 6),
                Icon(Icons.star, color: Colors.amber, size: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onMapTap() {
    customInfoWindowController.hideInfoWindow!();
  }

  void onCameraMove(CameraPosition position) {
    customInfoWindowController.onCameraMove!();
  }

  void onMapCreated(GoogleMapController controller) {
    customInfoWindowController.googleMapController = controller;
    print("Map created and controller is initialized: $controller");
  }
}
