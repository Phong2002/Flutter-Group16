import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/DateTimeUltis.dart';
import 'package:weather_app/utils/temperatureUltis.dart';

import '../Models/HourlyWeather.dart';

class HourlyWeatherWidget extends StatefulWidget {
  final List<Hourly> hourlyList;
  const HourlyWeatherWidget({super.key, required this.hourlyList});

  @override
  State<StatefulWidget> createState() {
    return _HourlyWeatherWidgetState();
  }
}

class _HourlyWeatherWidgetState extends State<HourlyWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: Row(
              children: const [
                Icon(
                  FontAwesomeIcons.clock,
                  size: 16,
                  color: Color.fromARGB(150, 255, 255, 255),
                ),
                Text(
                  " Dự báo 48h",
                  style: TextStyle(
                      color: Color.fromARGB(200, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for(var i=0;i<widget.hourlyList.length;i++)
                  if(i>=1)
                    if(!DateUtils.isSameDay(widget.hourlyList[i].dt,widget.hourlyList[i-1].dt))
                      HourlyWidget(hourly:widget.hourlyList[i],day: DatetimeUltis.showDayAndMonth(widget.hourlyList[i].dt),)
                    else
                      HourlyWidget(hourly:widget.hourlyList[i])
                ,
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class HourlyWidget extends StatefulWidget {
  final Hourly hourly;
  final String? day;

  const HourlyWidget({super.key, required this.hourly, this.day});

  @override
  State<StatefulWidget> createState() {
    return _HourlyWidgetState();
  }
}

class _HourlyWidgetState extends State<HourlyWidget> {
  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("###.#", "en_US");
    return
                Container(
                  width: 86,
                  child: Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text(widget.day != null?widget.day!:DatetimeUltis.showHourAndMinutes(widget.hourly.dt),
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      Text("${formatNumber.format(widget.hourly.windSpeed)}km/h",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Image(
                          image: NetworkImage(
                              "https://openweathermap.org/img/wn/${widget.hourly.weather![0].icon}.png")),
                      Container(
                          height: (widget.hourly.temp!.abs())*1.5,
                          width: 10,
                          decoration: BoxDecoration(
                            color: TemperatureUltis.colorTemperature(widget.hourly.temp!),
                            borderRadius: BorderRadius.circular(2),
                          )),
                      Text("${formatNumber.format(widget.hourly.temp!)}°",
                          style: TextStyle(color: Colors.white, fontSize: 18))
                    ],
                  ),
                );
  }
}

