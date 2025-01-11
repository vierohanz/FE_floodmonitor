import 'package:flood_monitor/controllers/mapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapC = Get.put(mapController());
    mapC.loadMapData();

    // Menyimpan id marker yang dipilih
    Rx<String?> selectedMarkerId = Rx<String?>(null);
    LatLng? initialPosition; // Menyimpan posisi awal kamera

    return Scaffold(
      body: Obx(() {
        if (mapC.mapData.value.pointLocation.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        // Mendapatkan posisi awal dari data perangkat
        if (initialPosition == null) {
          initialPosition = mapC.mapData.value.pointLocation.first;
        }

        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapC.setGoogleMapController(controller);
            if (selectedMarkerId.value == null) {
              // Jika tidak ada marker yang dipilih, posisikan kamera di awal
              mapC.googleMapController?.animateCamera(
                CameraUpdate.newLatLng(initialPosition!),
              );
            }
          },
          initialCameraPosition: CameraPosition(
            target: initialPosition!, // Posisikan kamera di awal
            zoom: 5,
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
          minMaxZoomPreference: MinMaxZoomPreference(3, 12),
        );
      }),
    );
  }
}
