import 'package:flutter/material.dart';
import '../Widgets/dailyWeatherForecast.dart';

class DailyWeatherPage extends StatelessWidget {
  const DailyWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: const DailyWeatherForecast(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

