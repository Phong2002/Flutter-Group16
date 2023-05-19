import 'package:flutter/material.dart';
import '../Widgets/searchLocation.dart';

class SearchLocationPage extends StatelessWidget {
  const SearchLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchLocation(),
      backgroundColor: Colors.white,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

