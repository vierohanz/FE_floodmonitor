import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapModel {
  final List<String> nameLocation;
  final List<LatLng> pointLocation;
  final List<String> imgLocation;

  mapModel(
      {required this.nameLocation,
      required this.pointLocation,
      required this.imgLocation});
}
