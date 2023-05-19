import 'package:uuid/uuid.dart';

class Location {
  String? id;
  double? lat;
  double? lon;
  String? locationName;
  Location(this.id,this.lat, this.lon, this.locationName);

  Location.fromJson(Map<String, dynamic> json) {
    id = const Uuid().v1();
    lat = json['lat'];
    lon = json['lon'];
    if(json['local_names']!=null){
      if (json['local_names']['vi']!=null){
        locationName = json['local_names']['vi'];
      }
      else {
        locationName =  json['name'];
      }
    }
    else {
      locationName =  json['name'];
    }
  }
}