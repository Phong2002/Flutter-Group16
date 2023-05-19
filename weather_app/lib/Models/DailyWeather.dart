import 'FeelsLike.dart';
import 'StateWeather.dart';
import 'Temp.dart';

class Daily {
 DateTime? dt;
 DateTime? sunrise;
 DateTime? sunset;
 DateTime? moonrise;
 DateTime? moonset;
 num? moonPhase;
 Temp? temp;
 FeelsLike? feelsLike;
 num? pressure;
 num? humidity;
 num? dewPoint;
 num? windSpeed;
 num? windDeg;
 num? windGust;
 List<WeatherState>? weather;
 num? clouds;
 num? pop;
 num? rain;
 num? uvi;

 Daily(
     {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.weather,
      this.clouds,
      this.pop,
      this.rain,
      this.uvi});

 Daily.fromJson(Map<String, dynamic> json) {
   dt =DateTime.fromMillisecondsSinceEpoch(json['dt']*1000) ;
  sunrise = DateTime.fromMillisecondsSinceEpoch(json['sunrise']*1000) ;
  sunset = DateTime.fromMillisecondsSinceEpoch(json['sunset']*1000) ;
  moonrise =DateTime.fromMillisecondsSinceEpoch(json['moonrise']*1000) ;
  moonset = DateTime.fromMillisecondsSinceEpoch(json['moonset']*1000) ;
  moonPhase = json['moon_phase']+0.0;
  temp = json['temp'] != null ? new Temp.fromJson(json['temp']) : null;
  feelsLike = json['feels_like'] != null
      ? new FeelsLike.fromJson(json['feels_like'])
      : null;
  pressure = json['pressure'];
  humidity = json['humidity'];
  dewPoint = json['dew_point']+0.0;
  windSpeed = json['wind_speed']+0.0;
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
  clouds = json['clouds'];
  pop = json['pop']+0.0;
   if (json['rain'] != null) {
     rain = json['wind_gust']+0.0;
   }
  uvi = json['uvi']+0.0;
 }

}