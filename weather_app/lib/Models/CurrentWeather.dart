import 'StateWeather.dart';

class Current {
   DateTime? dt;
   DateTime? sunrise;
   DateTime? sunset;
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

   Current(
       {this.dt,
          this.sunrise,
          this.sunset,
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
          this.weather});

   Current.fromJson(Map<String, dynamic> json) {
      dt =DateTime.fromMillisecondsSinceEpoch(json['dt']*1000) ;
      sunrise = DateTime.fromMillisecondsSinceEpoch(json['sunrise']*1000);
      sunset = DateTime.fromMillisecondsSinceEpoch(json['sunset']*1000);
      temp = json['temp'];
      feelsLike = json['feels_like']+.0;
      pressure = json['pressure'];
      humidity = json['humidity'];
      dewPoint = json['dew_point']+.0;
      uvi = json['uvi'];
      clouds = json['clouds'];
      visibility = json['visibility'];
      windSpeed = json['wind_speed']+.0;
      windDeg = json['wind_deg'];
      if (json['wind_gust'] != null) {
        windGust = json['wind_gust']+0.0;
      }
      windGust = json[''];
      if (json['weather'] != null) {
         weather = <WeatherState>[];
         json['weather'].forEach((v) {
            weather!.add(new WeatherState.fromJson(v));
         });
      }
   }

}