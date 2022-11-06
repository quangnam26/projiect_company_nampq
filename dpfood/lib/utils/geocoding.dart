// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:geolocator/geolocator.dart';

class Geocoding {
  Geocoding();

  Future<bool> requiredPermission() async {
    final permission = await Geolocator.checkPermission();
    if (checkPermission(permission)) {
      final geoPermission = await Geolocator.requestPermission();
      if (checkPermission(geoPermission)) {
        Geolocator.openLocationSettings();
        return false;
      }
      return true;
    }
    return true;
  }

  ///
  /// Not permission @return [true]
  ///
  bool checkPermission(LocationPermission permission) {
    return LocationPermission.denied == permission || permission == LocationPermission.deniedForever || LocationPermission.unableToDetermine == permission;
  }

  Future<Position> getCurrentPosition() async {
    if (checkPermission(await Geolocator.checkPermission())) {
      final status = await requiredPermission();
      if (status == true) {
        return Geolocator.getCurrentPosition();
      }
      throw Exception("Not permission");
    } else {
      return Geolocator.getCurrentPosition();
    }
  }
}
