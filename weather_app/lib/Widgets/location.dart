import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/searchLocationPage.dart';
import 'package:weather_app/Widgets/searchLocation.dart';

import '../Provider/weatherProvider.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return SearchLocationPage();
              }));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(230, 220, 220, 220),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Icon(Icons.search, color: Color.fromARGB(255, 120, 120, 120)),
                  Text(
                    "Nhập vị trí",
                    style: TextStyle(
                        color: Color.fromARGB(255, 120, 120, 120),
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                for (var location
                    in context.watch<WeatherProvider>().locationList)
                  InkWell(child: Text(location.locationName.toString()),
                  onTap: (){context.read<WeatherProvider>().removeLocation(location.id!);},
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
