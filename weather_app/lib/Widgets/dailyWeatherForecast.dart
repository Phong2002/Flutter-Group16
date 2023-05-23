import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/DailyWeather.dart';

import '../utils/BackgroundUltis.dart';
import '../utils/DateTimeUltis.dart';

class DailyWeatherForecast extends StatefulWidget {
  final List<Daily> dailyList;

  const DailyWeatherForecast({super.key, required this.dailyList});

  @override
  State<StatefulWidget> createState() {
    return _DailyWeatherForecastState();
  }
}

class _DailyWeatherForecastState extends State<DailyWeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var daily in widget.dailyList) DailyWidget(daily: daily)
        ],
      ),
    );
  }
}

class DailyWidget extends StatefulWidget {
  final Daily daily;

  const DailyWidget({super.key, required this.daily});

  @override
  State<StatefulWidget> createState() {
    return _DailyWidgetState();
  }
}

class _DailyWidgetState extends State<DailyWidget> {
  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("###.#", "en_US");
    return Container(
      width: 200,
      height: 500,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: AssetImage(
                  BackgroundUltis.backgroundImageFromWeatherConditionCodes(
                      widget.daily.weather![0].id!, true)!),
              fit: BoxFit.cover,
              alignment: Alignment.center)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(0, 0, 0, 0.3),
        ),
        child: Column(
          children: [
            Text(
              DateFormat.EEEE('vi').format(widget.daily.dt!),
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(DatetimeUltis.showDayAndMonth(widget.daily.dt!),
                style: const TextStyle(fontSize: 14, color: Colors.white)),
            Image(
                image: NetworkImage(
                    "https://openweathermap.org/img/wn/${widget.daily.weather![0].icon}.png")),
            Text(widget.daily.weather![0].description!,
                style: const TextStyle(fontSize: 14, color: Colors.white)),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(100, 100, 100, 0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nhiệt độ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Column(
                    children: [
                      ParameterWidget(
                          label: "Ngày",
                          value: '${widget.daily.temp!.day!.toInt()}°'),
                      ParameterWidget(
                          label: "Đêm",
                          value: '${widget.daily.temp!.night!.toInt()}°'),
                      ParameterWidget(
                          label: "Cao nhất",
                          value: '${widget.daily.temp!.max!.toInt()}°'),
                      ParameterWidget(
                          label: "Thấp nhất",
                          value: '${widget.daily.temp!.min!.toInt()}°'),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(100, 100, 100, 0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Các thông số khác",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Column(
                    children: [
                      ParameterWidget(
                          label: "Độ ẩm",
                          value:
                              "${formatNumber.format(widget.daily.humidity)}%"),
                      ParameterWidget(
                          label: "Chỉ số UV",
                          value: "${widget.daily.uvi?.toInt()}"),
                      ParameterWidget(
                          label: "Áp suất", value: "${widget.daily.pressure} "),
                      ParameterWidget(
                          label: "Có thể mưa",
                          value:
                              "${formatNumber.format(widget.daily.pop! * 100.toInt())}%"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ParameterWidget extends StatelessWidget {
  final String label;
  final String value;

  const ParameterWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          //                   <--- left side
          color: Color.fromRGBO(200, 200, 200, 0.5),
          width: 0.5,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
            Text(value,
                style: const TextStyle(color: Colors.white, fontSize: 15))
          ],
        ));
  }
}
