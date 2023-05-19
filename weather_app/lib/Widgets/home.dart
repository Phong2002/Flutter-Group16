import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Models/Weather.dart';
import 'package:weather_app/Provider/weatherProvider.dart';
import 'package:weather_app/Widgets/appbar.dart';
import 'package:weather_app/Widgets/currentWeatherWidget.dart';
import 'package:weather_app/Widgets/dailyWeatherWidget.dart';
import 'package:weather_app/Widgets/hourlyWeatherWidget.dart';
import 'package:weather_app/Widgets/suntime.dart';

import 'compassWidget.dart';
import 'otherParameters.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String urlBackgroud = 'assets/gif/clear-sky.gif';
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      syncDataFireBase();
    });
  }



  void syncDataFireBase() async {
    if (!mounted) {
      return;
    } else{
      await context.read<WeatherProvider>().dataSync();
      await context.read<WeatherProvider>().getAllWeather();
    }
  }
  

  List<String> urlsBG = [
    "assets/gif/clear-sky.gif",
    "assets/images/login-background.gif"
  ];

  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(urlBackgroud),
                fit: BoxFit.cover,
                alignment: Alignment.center)),
        child: Consumer<WeatherProvider>(builder: (context, value, child) {
          final weatherList = value.weatherList;
          if (value.isLoadData==true||value.weatherList.length==0){
            return Column(
              children: const [
                WeatherAppBar(
                    currentPage: 0,
                    locationName: "Thêm địa điểm",
                    totalPage: 0),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          else {
            return Column(children: [
              WeatherAppBar(
                  currentPage: currentPage>value.weatherList.length-1?value.weatherList.length-1:currentPage,
                  locationName: provider
                          .weatherList[currentPage>value.weatherList.length-1?value.weatherList.length-1:currentPage].location?.locationName ??
                      "",
                  totalPage: weatherList.length),
              Expanded(
                child: PageView.builder(
                    itemCount: weatherList.length,
                    pageSnapping: true,
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                        urlBackgroud = urlsBG[0];
                      });
                    },
                    itemBuilder: (context, pagePosition) {
                      return WeatherWidget(weather: provider.weatherList[currentPage>value.weatherList.length-1?value.weatherList.length-1:currentPage],);
                    }),
              )
          ]);
          }
        }),
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget{
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  _WeatherWidgetState createState()=> _WeatherWidgetState();

}

class _WeatherWidgetState extends State<WeatherWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CurrentWeatherWidget(
                current: widget.weather.current!,
                daily:widget.weather.daily![0]!,
              ),
              DailyWeatherWidget(
                  daily: widget.weather.daily!),
              HourlyWeatherWidget(
                  hourlyList:widget.weather.hourly!),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        CompassWidget(
                          windSpeed: widget.weather.current!
                              .windSpeed!,
                          windDeg: widget.weather.current!
                              .windDeg!,
                        ),
                        SuntimeWidget(
                            sunrise: widget.weather.current!
                                .sunrise!,
                            sunset: widget.weather.current!
                                .sunset!)
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: OtherParameterWidget(
                        current: widget.weather.current!,
                        pop: widget.weather.daily![0].pop!,
                      ))
                ],
              ),
            ],
          ),
        ));
  }

}

