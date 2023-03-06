import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget number_Btn(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () => {calculate(btnText)},
      child: Text(
        btnText,
        style: TextStyle(fontSize: 24, color: txtColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(60, 60),
        shape: CircleBorder(),
        primary: btnColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 163, 163),
      appBar: AppBar(
        title: Text('CASIO IPHONE'),
        backgroundColor: Color.fromARGB(255, 244, 163, 163),
        centerTitle: true,
        shape: StadiumBorder(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 70),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                number_Btn('AC', Colors.grey, Colors.black),
                number_Btn('+/-', Colors.grey, Colors.black),
                number_Btn('%', Colors.grey, Colors.black),
                number_Btn('/', Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                number_Btn('7', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('8', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('9', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('x', Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                number_Btn('4', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('5', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('6', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('-', Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                number_Btn('1', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('2', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('3', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('+', Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(7, 7, 75, 5),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: (Color.fromARGB(255, 97, 97, 97))),
                ),
                number_Btn(',', Color.fromARGB(255, 80, 79, 79), Colors.white),
                number_Btn('=', Colors.orange, Colors.white)
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  int firstNumber = 0;
  int secondNumber = 0;
  String result = "";
  String text = "";
  String operation = "";

  void calculate(String btnText) {
    if (btnText == "C") {
      result = "";
      text = "";
      firstNumber = 0;
      secondNumber = 0;
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/") {
      firstNumber = int.parse(text);
      result = "";
      operation = btnText;
    } else if (btnText == "=") {
      secondNumber = int.parse(text);
      if (operation == "+") {
        result = (firstNumber + secondNumber).toString();
      }
      if (operation == "-") {
        result = (firstNumber - secondNumber).toString();
      }
      if (operation == "x") {
        result = (firstNumber * secondNumber).toString();
      }
      if (operation == "/") {
        result = (firstNumber ~/ secondNumber).toString();
      }
    } else {
      result = int.parse(text + btnText).toString();
    }
    setState(() {
      text = result;
    });
  }
}
