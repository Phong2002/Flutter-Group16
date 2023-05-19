import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Home(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
