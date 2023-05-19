import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/Infrastructure/requester.dart';
import 'package:weather_app/Models/Location.dart';
import 'dart:convert' as convert;

import '../Models/Weather.dart';
import '../Services/Location.dart';

class WeatherProvider extends ChangeNotifier {
  List<Location> locationList = [];
  List<Weather> weatherList = [];
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  bool isLoadData = true;

  Future<void> addNewLocation(Location location) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("$uid/${location.id}");
    await ref.set({
      "lat": location.lat,
      "lon": location.lon,
      "locationName": location.locationName
    });
    locationList.add(location);
    await Requester.getWeatherByLocation(location)
        .then((value) => {weatherList.add(value!), notifyListeners()});
    notifyListeners();
  }

  Future<void> removeLocation(String id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("$uid/$id");
    await ref.remove();
    Location location = locationList.where((e) => e.id == id).first;
    Weather weather =
        weatherList.where((e) => e.location?.id == location.id).first;
    weatherList.remove(weather);
    notifyListeners();
    locationList.remove(location);
    notifyListeners();
  }

  bool isExistsLocation(Location location) {
    bool isExists = locationList
        .where((e) => e.locationName == location.locationName)
        .isNotEmpty;
    return isExists;
  }

  Future<void> dataSync() async {
    locationList=[];
    print("locationlist-length 1  ${locationList.length}");
    Location currentLocation = Location(
        '1',
        LocationService.currentLocation.latitude,
        LocationService.currentLocation.longitude,
        LocationService.locationName[0].name);
    locationList.add(currentLocation);
    DatabaseReference userLocationsRef =
        FirebaseDatabase.instance.ref().child("$uid");
    print("locationlist-length  2 ${locationList.length}");
    final event = await userLocationsRef.once();
    if (event.snapshot.children.isNotEmpty) {
      for (var child in event.snapshot.children) {
        String locationName = child.child('locationName').value.toString();
        double? lat = double.tryParse(child.child('lat').value.toString());
        double? lon = double.tryParse(child.child('lon').value.toString());
        Location location = Location(child.key, lat, lon, locationName);
        locationList.add(location);
      }
    }
    print("locationlist-length  3 ${locationList.length}");
    notifyListeners();
  }

  Future<void> getAllWeather() async {
    weatherList = [];
    notifyListeners();
    isLoadData = true;
    notifyListeners();
    print("----------------length -- ${locationList.length}");
    for (var location in locationList) {
      print("----------------locationname -- ${location.locationName}");
      Weather weather = await Requester.getWeatherByLocation(location);
      weatherList.add(weather);
      print("----------------for -- ${weatherList.length}");
      isLoadData = false;
      notifyListeners();
    }
    isLoadData = false;
    notifyListeners();
  }
}
