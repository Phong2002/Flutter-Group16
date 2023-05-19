import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/Screens/LocationPage.dart';
import '../Screens/loginPage.dart';

class WeatherAppBar extends StatefulWidget {
  final String locationName;
  final int totalPage;
  final int currentPage;

  const WeatherAppBar(
      {super.key,
      required this.locationName,
      required this.totalPage,
      required this.currentPage});

  @override
  _WeatherAppBarState createState() => _WeatherAppBarState();
}

class _WeatherAppBarState extends State<WeatherAppBar> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LocationPage();
                  }));
                },
                icon: const Icon(FontAwesomeIcons.plus),
                color: Colors.white,
              ),
              Text(
                widget.locationName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton(
                    child: const CircleAvatar(
                      backgroundColor: Colors.amber,
                      backgroundImage: NetworkImage(
                          "https://genzrelax.com/wp-content/uploads/2023/03/anh-vu-to-0.jpg"),
                    ),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    offset: Offset(0, 0),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text("Cài đặt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                            child: Text("Đăng xuất",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 0) {
                      } else if (value == 1) {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const LoginPage();
                          },
                        ));
                      }
                    }),
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.totalPage; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Icon(
                      Icons.lens,
                      color:
                          i == widget.currentPage ? Colors.white : Colors.grey,
                      size: 8,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

