import 'package:flutter/material.dart';
import 'package:weather_app/Models/CurrentWeather.dart';
import 'package:weather_app/Models/DailyWeather.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final Current current;
  final Daily daily;
  const CurrentWeatherWidget({super.key, required this.current, required this.daily});


  @override
  State<StatefulWidget> createState() {
    return _CurrentWeatherWidgetState();
  }
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    print("========================wdiget current");
    return Container(
      margin: EdgeInsets.symmetric(vertical: 60),
      padding: EdgeInsets.only(left: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                widget.current.temp!.round().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 100),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("°C",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Text(
            "${widget.current.weather![0].description} ${widget.daily.temp?.min?.toInt()}°/${widget.daily.temp?.max?.toInt()}°",
            style: TextStyle(
                color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
