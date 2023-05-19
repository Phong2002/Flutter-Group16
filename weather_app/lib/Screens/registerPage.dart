import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Register(),
      backgroundColor: Color.fromARGB(255, 200, 216, 227),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

