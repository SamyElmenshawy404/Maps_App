import 'package:geolocator/geolocator.dart';

class LocationHelper {
  // static Future<Position> getCurrentLocation() async {
  //   bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!isServiceEnabled) {
  //     await Geolocator.requestPermission();
  //   }
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }
  static Future<Position?> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }
}
