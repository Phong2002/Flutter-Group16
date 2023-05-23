import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/utils/compassUltis.dart';

class CompassWidget extends StatefulWidget {
  final num windSpeed;
  final num windDeg;

  const CompassWidget(
      {super.key, required this.windSpeed, required this.windDeg});

  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(
                FontAwesomeIcons.wind,
                size: 18,
                color: Colors.white,
              ),
              Text(
                "Tốc độ gió",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                        CompassUltis.degreeToCompassDirection(widget.windDeg),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text("${widget.windSpeed.toInt()} km/h",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/compass/compass.png',
                          height: 70,
                          color: const Color.fromRGBO(241, 241, 241, 0.8)),
                      // Ảnh đè dưới
                      Transform.rotate(
                        angle: widget.windDeg * 3.1415926535 / 180,
                        // Ảnh đè trên
                        alignment: Alignment.center,
                        // Đổi độ sang radian
                        child: Image.asset('assets/images/compass/directionNeedle.png',
                            height: 70,
                            color: const Color.fromRGBO(241, 241, 241, 0.8)),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
