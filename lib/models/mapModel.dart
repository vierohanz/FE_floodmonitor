import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapModel {
  List<String> nameLocation;
  List<LatLng> pointLocation;

  mapModel({
    required this.nameLocation,
    required this.pointLocation,
  });
}
