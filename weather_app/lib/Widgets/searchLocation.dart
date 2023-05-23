import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Infrastructure/requester.dart';
import 'package:weather_app/Models/Location.dart';
import 'package:weather_app/Provider/weatherProvider.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  TextEditingController search = TextEditingController();
  List<Location> locationList = <Location>[];

  @override
  void initState() {
    super.initState();
  }

  void handleSearch() {
    Requester.searchLocation(search.text).then((value) => {
          setState(
            () {
              locationList = value;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
      Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(230, 220, 220, 220),
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                      autofocus: true,
                      style: TextStyle(fontSize: 18),
                      controller: search,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                search.text = "";
                              });
                            },
                            icon: Icon(Icons.cancel_rounded),
                            iconSize: 18,
                          ))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: const Text(
                  "Hủy",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 79, 248), fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    handleSearch();
                  },
                  child: const Text("Tìm kiếm")),
              for (var location in locationList)
                LocationWidget(location: location!, isExists: Provider.of<WeatherProvider>(context,listen: true).isExistsLocation(location),),
            ],
          ),
        ),
      )
        ],
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  final bool isExists;
  final Location location;
  const LocationWidget({super.key, required this.location, required this.isExists});

  @override
  _LocationWidgetState createState() => _LocationWidgetState();


}
class _LocationWidgetState extends State<LocationWidget>{
  bool Exists = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      Exists=widget.isExists;
    });
    return InkWell(
      onTap: (){},
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(220, 220, 220, 0.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.location.locationName!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(100, 100, 100, 1)),
            ),
            if(Exists)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: const [
                    Text("Đã thêm",style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1),fontSize: 16),),
                    Icon(FontAwesomeIcons.chevronRight,size: 16,color: Color.fromRGBO(100, 100, 100, 1),weight:600,)
                  ],
                ),
              )
            else
              IconButton(
                onPressed: () {context.read<WeatherProvider>().addNewLocation(widget.location);
                setState(() {
                  Exists=true;
                });
                  },
                icon: const Icon(FontAwesomeIcons.circlePlus),
                color: Colors.grey,
                iconSize: 36,
              )
          ],
        ),
      ),
    );
}
}


