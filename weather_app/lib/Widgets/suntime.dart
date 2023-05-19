import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/utils/compassUltis.dart';

import '../utils/DateTimeUltis.dart';

class SuntimeWidget extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const SuntimeWidget({super.key, required this.sunrise, required this.sunset});

  @override
  _SuntimeWidgetState createState() => _SuntimeWidgetState();
}

class _SuntimeWidgetState extends State<SuntimeWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.sun,
                size: 18,
                color: Colors.white,
              ),
              Text(
                " Mặt trời",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/suntime.png"),
                      fit: BoxFit.cover,opacity: 0.5,
                      )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bình minh ${DatetimeUltis.showHourAndMinutes(widget.sunset)}",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Hoàng hôn ${DatetimeUltis.showHourAndMinutes(widget.sunrise)}",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
