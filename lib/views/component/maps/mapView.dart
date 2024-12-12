import 'package:flood_monitor/controllers/mapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapC = Get.put(mapController());
    mapC.loadSelectedValue();

    return Scaffold(
      body: Obx(() {
        if (mapC.mapData.value.pointLocation.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        LatLng initialPosition = mapC.mapData.value.pointLocation.first;

        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            mapC.setGoogleMapController(controller);
          },
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 10,
          ),
          markers: mapC.mapData.value.pointLocation.map((point) {
            return Marker(
              markerId: MarkerId(point.toString()),
              position: point,
              infoWindow: InfoWindow(
                title: mapC.mapData.value.nameLocation.first,
              ),
            );
          }).toSet(),
          onCameraMove: (position) {},
        );
      }),
    );
  }
}
