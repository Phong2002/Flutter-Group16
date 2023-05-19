import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/CurrentWeather.dart';

class OtherParameterWidget extends StatefulWidget {
  final Current current;
  final num pop;


  const OtherParameterWidget(
      {super.key, required this.current, required this.pop,  });

  @override
  _OtherParameterWidgetState createState() => _OtherParameterWidgetState();
}

class _OtherParameterWidgetState extends State<OtherParameterWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("###.#", "en_US");
    return Container(
      height: 250,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Icon(
                FontAwesomeIcons.database,
                size: 18,
                color: Colors.white,
              ),
              Text(
                "Thông số khác",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ParameterWidget(label:"Độ ẩm", value: "${formatNumber.format(widget.current.humidity)}%"),
                ParameterWidget(label:"Cảm giác như", value: "${formatNumber.format(widget.current.feelsLike?.toInt())}°"),
                ParameterWidget(label:"Chỉ số UV", value: "${widget.current.uvi?.toInt()}"),
                ParameterWidget(label:"Áp suất", value: "${widget.current.pressure} "),
                ParameterWidget(label:"Tầm nhìn", value: "${formatNumber.format(widget.current.visibility!/1000)} km"),
                ParameterWidget(label:"Có thể mưa", value: "${formatNumber.format(widget.pop*100.toInt())}%"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ParameterWidget extends StatefulWidget {
  final String label;
  final String value;

  const ParameterWidget({super.key, required this.label, required this.value});

  @override
  _ParameterWidgetState createState() => _ParameterWidgetState();
}

class _ParameterWidgetState extends State<ParameterWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide( //                   <--- left side
                color: Color.fromRGBO(200, 200, 200, 0.8),
                width: 1,
              ))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label,
            style: const TextStyle(fontSize: 16, color: Color.fromRGBO(
                245, 245, 245, 1.0)),),
          Text(widget.value,
            style: const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
