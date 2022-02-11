import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  static LatLng formData(Map data) {
    return LatLng(data['lat'], data['lon']);
  }
}