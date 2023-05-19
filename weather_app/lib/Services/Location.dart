import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService{
  static late Position currentLocation;
  static late List<Placemark> locationName;
  static Future<void> locateUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentLocation= await Geolocator.getCurrentPosition();
    locationName=await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
  }

}