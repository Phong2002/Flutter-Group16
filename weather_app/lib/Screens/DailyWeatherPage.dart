import 'package:flutter/material.dart';
import '../Models/DailyWeather.dart';
import '../Widgets/dailyWeatherForecast.dart';

class DailyWeatherPage extends StatelessWidget {
  final List<Daily> dailyList;
  final String title;
  const DailyWeatherPage({super.key, required this.dailyList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(title),),
      body:  DailyWeatherForecast(dailyList: dailyList),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

