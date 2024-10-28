import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/mapModel.dart';

class mapController extends GetxController {
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> markers = {};

  final mapM = mapModel(
    nameLocation: ["Polines", "Pekalongan", "Brebes"],
    pointLocation: [
      const LatLng(-7.052196421969724, 110.4355492705154),
      const LatLng(-6.891850, 109.669352),
      const LatLng(-6.854984, 109.040209),
    ],
    imgLocation: [
      "assets/images/polines_cover.jpeg",
      "assets/images/pekalongan.jpg",
      "assets/images/brebes.jpg",
    ],
  );

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  void loadMarkers() {
    for (int i = 0; i < mapM.pointLocation.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: mapM.pointLocation[i],
          onTap: () {
            if (customInfoWindowController.addInfoWindow != null) {
              customInfoWindowController.addInfoWindow!(
                _buildInfoWindowContent(i),
                mapM.pointLocation[i],
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

  Widget _buildInfoWindowContent(int index) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mapM.imgLocation[index].startsWith('assets/'))
            Image.asset(
              mapM.imgLocation[index],
              height: 100,
              width: 250,
              fit: BoxFit.cover,
            )
          else
            Image.network(
              mapM.imgLocation[index],
              height: 100,
              width: 250,
              fit: BoxFit.cover,
            ),
          Container(
            padding: EdgeInsets.all(4),
            child: Text(
              mapM.nameLocation[index],
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
                // Text("(5)"),
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
