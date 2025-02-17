import 'package:flood_monitor/controllers/mapController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gestures/gestures.dart';

class mapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapC = Get.put(mapController());
    mapC.loadMapData();
    Rx<String?> selectedMarkerId = Rx<String?>(null);
    LatLng? initialPosition;

    return Scaffold(
      body: Obx(() {
        if (mapC.mapData.value.pointLocation.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (initialPosition == null) {
          initialPosition = mapC.mapData.value.pointLocation.first;
        }

        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapC.setGoogleMapController(controller);
            if (selectedMarkerId.value == null) {
              mapC.googleMapController?.animateCamera(
                CameraUpdate.newLatLng(initialPosition!),
              );
            }
          },
          initialCameraPosition: CameraPosition(
            target: initialPosition!,
            zoom: 20,
          ),
          markers:
              mapC.mapData.value.pointLocation.asMap().entries.map((entry) {
            int index = entry.key;
            LatLng point = entry.value;

            return Marker(
              markerId: MarkerId(point.toString()),
              position: point,
              infoWindow: InfoWindow(
                title: mapC.mapData.value.nameLocation[index],
              ),
              onTap: () {
                // Ketika marker dipilih, ubah posisi kamera ke marker tersebut
                if (selectedMarkerId.value == point.toString()) {
                  // Jika marker yang sama dipilih, matikan kontrol posisi tengah
                  selectedMarkerId.value = null; // Reset pilihan marker
                  mapC.googleMapController?.animateCamera(
                    CameraUpdate.newLatLng(
                        initialPosition!), // Kembali ke posisi awal
                  );
                } else {
                  selectedMarkerId.value = point.toString();
                  mapC.googleMapController?.animateCamera(
                    CameraUpdate.newLatLng(
                        point), // Pindahkan kamera ke marker baru
                  );
                }
              },
            );
          }).toSet(),
          onCameraMove: (position) {
            print('Camera moved to: ${position.target}');
          },
          onCameraIdle: () {},
          // Perluas batas zoom minimum dan maksimum untuk memperbolehkan zoom penuh
          minMaxZoomPreference: MinMaxZoomPreference(1, 20), // Maksimalkan zoom
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer())
          }, // Tambahkan gestureRecognizers
        );
      }),
    );
  }
}
