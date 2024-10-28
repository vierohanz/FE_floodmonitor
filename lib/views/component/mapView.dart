import 'package:custom_info_window/custom_info_window.dart';
import 'package:flood_monitor/controllers/mapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapView extends StatelessWidget {
  mapController mapC = Get.put(mapController());

  @override
  Widget build(BuildContext context) {
    final hp = MediaQuery.of(context).size.height;
    final wp = MediaQuery.of(context).size.width;
    print("mapController instance: ${mapC.customInfoWindowController}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          GetBuilder<mapController>(
            builder: (controller) {
              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-7.052196421969724, 110.4355492705154),
                  zoom: 14,
                ),
                markers: mapC.markers,
                onTap: (argument) {
                  mapC.onMapTap();
                },
                onCameraMove: (position) {
                  mapC.onCameraMove(position);
                },
                onMapCreated: (GoogleMapController controller) {
                  mapC.onMapCreated(controller);
                },
              );
            },
          ),
          GetBuilder<mapController>(
            builder: (controller) {
              return CustomInfoWindow(
                controller: mapC.customInfoWindowController,
                height: hp * 0.2,
                width: wp * 0.3,
                offset: 3,
              );
            },
          ),
        ],
      ),
    );
  }
}
