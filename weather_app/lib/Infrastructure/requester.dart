import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/Models/Location.dart';

import '../Models/Weather.dart';

class Requester{
  static final String _urlWeather=dotenv.get("API_WEATHER");
  static final String _urlMap=dotenv.get("API_MAP");
  static final String _apiKey=dotenv.get("API_KEY");

  static Future<List<Location>> searchLocation(String search) async {
    var url = Uri.parse("${_urlMap}direct?q=$search&limit=5&appid=$_apiKey");
    var response = await http.get(url);
    List<Location> locationList = <Location>[];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse is List) {
        for (var value in jsonResponse) {
          locationList.add(Location.fromJson(value));
        }
      } else {
        print('Invalid JSON response.');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return locationList;
  }

  static Future<Weather> getWeatherByLocation(Location location) async {
    var url = Uri.parse("${_urlWeather}onecall?lat=${location.lat}&lon=${location.lon}&lang=vi&appid=$_apiKey&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
     Weather weather = Weather.fromJson(jsonResponse,location);
      return weather;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  return Weather();
  }
}