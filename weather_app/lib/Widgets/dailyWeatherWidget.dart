import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/DailyWeather.dart';
import 'package:weather_app/Screens/DailyWeatherPage.dart';

class DailyWeatherWidget extends StatefulWidget {
  final List<Daily> daily;
  final String currentLocation;
  const DailyWeatherWidget({super.key, required this.daily, required this.currentLocation});


  @override
  State<StatefulWidget> createState() {
    return _DailyWeatherWidgetState();
  }
}

class _DailyWeatherWidgetState extends State<DailyWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10,top: 5),
            child:
            Row(
              children: const [
                Icon(Icons.calendar_month_rounded,color: Color.fromARGB(150, 255, 255, 255),),
                Text(" Dự báo 8 ngày",
                  style: TextStyle(color:Color.fromARGB(200, 255, 255, 255),fontSize: 18 ,fontWeight: FontWeight.w600),)
              ],
            ),
          ),
          for(var i=0;i<4;i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(image: NetworkImage(
                      "https://openweathermap.org/img/wn/${widget.daily[i].weather![0].icon}.png")),
                  Text("${DateFormat.EEEE('vi').format(widget.daily[i].dt!)} ${widget.daily[i].weather![0].description}",
                      style: const TextStyle(fontSize: 18, color: Colors.white))
                ],
              ),
              Text("${widget.daily[i].temp!.min!.round()}° / ${widget.daily[i].temp!.max!.round()}°",
                  style: const TextStyle(fontSize: 18, color: Colors.white))
            ],
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                   Colors.white.withOpacity(0.5),
                  fixedSize: const Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return  DailyWeatherPage(dailyList: widget.daily,title: "Dự báo 8 ngày tại ${widget.currentLocation}",);
                  },
                ));
              },
              child: const Text("Dự báo 8 ngày", style: TextStyle(fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
}
