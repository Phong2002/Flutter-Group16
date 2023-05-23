import 'package:weather_app/Models/Location.dart';

import 'CurrentWeather.dart';
import 'DailyWeather.dart';
import 'HourlyWeather.dart';

class Weather {
  Location? location;
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;
  List<Hourly>? hourly;
  List<Daily>? daily;

  Weather(
      {this.lat,
        this.lon,
        this.timezone,
        this.timezoneOffset,
        this.current,
        this.hourly,
        this.daily});

  Weather.fromJson(Map<String, dynamic> json,Location this.location) {
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : null;
    if (json['hourly'] != null) {
      hourly = <Hourly>[];
      json['hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v));
      });
    }
    if (json['daily'] != null) {
      daily = <Daily>[];
      json['daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v));
      });
      print('------------------------------------id${daily![0].weather![0].id}------${daily![0].weather![0].description}');
    }
  }

}

