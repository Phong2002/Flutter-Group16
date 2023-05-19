import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
     backgroundColor: Color.fromARGB(255, 200, 216, 227),

     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

