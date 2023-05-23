import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/searchLocationPage.dart';
import 'package:weather_app/Widgets/searchLocation.dart';

import '../Provider/weatherProvider.dart';
import '../utils/BackgroundUltis.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool isSelect = false;
  List<String> idSelected = [];

  @override
  void initState() {
    super.initState();
  }

  bool isExistsInList(String id) {
    return idSelected.contains(id);
  }

  void addToList(String id) {
    setState(() {
      idSelected.add(id);
    });
  }

  void removeToList(String id) {
    setState(() {
      idSelected.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý thành phố"),
        centerTitle: true,
        leading: isSelect
            ? IconButton(
                onPressed: () {
                  setState(() {
                    idSelected = [];
                    isSelect = false;
                  });
                },
                icon: const Icon(
                  Icons.close,
                  size: 35,
                ),
              )
            : null,
        actions: isSelect && idSelected.isNotEmpty
            ? [
                IconButton(
                    onPressed: () {
                      for (var locationId in idSelected) {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .removeLocation(locationId);
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.trash))
              ]
            : [],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return const SearchLocationPage();
                }));
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(230, 220, 220, 220),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: const [
                    Icon(Icons.search,
                        color: Color.fromARGB(255, 120, 120, 120)),
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
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0;
                      i < context.watch<WeatherProvider>().weatherList.length;
                      i++)
                    InkWell(
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(BackgroundUltis
                                      .backgroundImageFromWeatherConditionCodes(
                                          context
                                                  .watch<WeatherProvider>()
                                                  .locationList
                                                  .isNotEmpty
                                              ? context
                                                  .watch<WeatherProvider>()
                                                  .weatherList![i]
                                                  .current!
                                                  .weather![0]
                                                  .id!
                                              : 0,
                                          true)!),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center),
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(230, 230, 230, 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context
                                    .watch<WeatherProvider>()
                                    .locationList[i]
                                    .locationName
                                    .toString(),
                                style: const TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 20),
                              ),
                              Row(
                                children: [
                                  Text('${context
                                      .watch<WeatherProvider>()
                                      .weatherList[i]
                                      .current!.temp!.toInt().toString()}°',style: TextStyle(color: Colors.white,fontSize: 35),),
                                  if (isSelect == true &&
                                      isExistsInList(context
                                          .watch<WeatherProvider>()
                                          .locationList[i]
                                          .id!) ==
                                          true)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        FontAwesomeIcons.circleCheck,
                                        color: Color.fromRGBO(
                                            176, 209, 255, 1.0),
                                      ),
                                    )
                                  else if (isSelect == true &&
                                      isExistsInList(context
                                          .watch<WeatherProvider>()
                                          .locationList[i]
                                          .id!) ==
                                          false)
                                        const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child:Icon(FontAwesomeIcons.circle,
                                      color: Color.fromRGBO(
                                          176, 209, 255, 1.0),))
                                ],
                              )

                            ],
                          )),
                      onTap: () {
                        if (isSelect == false) {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .changePage(i);
                          Navigator.pop(context);
                        } else if (isSelect == true &&
                            isExistsInList(Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .locationList[i]
                                    .id!) ==
                                true) {
                          removeToList(Provider.of<WeatherProvider>(context,
                                  listen: false)
                              .locationList[i]
                              .id!);
                        } else if (isSelect == true &&
                            isExistsInList(Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .locationList[i]
                                    .id!) ==
                                false) {
                          addToList(Provider.of<WeatherProvider>(context,
                                  listen: false)
                              .locationList[i]
                              .id!);
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          isSelect = true;
                        });
                      },
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
