import 'package:weather_app/Models/StateWeather.dart';

import 'Rain.dart';

class Hourly {
  DateTime? dt;
  num? temp;
  num? feelsLike;
  num? pressure;
  num? humidity;
  num? dewPoint;
  num? uvi;
  num? clouds;
  num? visibility;
  num? windSpeed;
  num? windDeg;
  num? windGust;
  List<WeatherState>? weather;
  num? pop;
  Rain? rain;

  Hourly(
      {this.dt,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.dewPoint,
        this.uvi,
        this.clouds,
        this.visibility,
        this.windSpeed,
        this.windDeg,
        this.windGust,
        this.weather,
        this.pop,
        this.rain});

  Hourly.fromJson(Map<String, dynamic> json) {
    dt =DateTime.fromMillisecondsSinceEpoch(json['dt']*1000) ;
    temp = json['temp']+.0 ;
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi']+.0;
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    if (json['wind_gust'] != null) {
      windGust = json['wind_gust']+0.0;
    }
    if (json['weather'] != null) {
      weather = <WeatherState>[];
      json['weather'].forEach((v) {
        weather!.add(new WeatherState.fromJson(v));
      });
    }
    pop = json['pop']+.0;
    rain = json['rain'] != null ? new Rain.fromJson(json['rain']) : null;
  }
}