import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Calculator",
      home: CalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(bottom: 40, top: 40),
          child: Column(
          children: [
          Expanded(
          child: Container(
          color: Colors.white, // <-- add this
          alignment: Alignment.bottomRight,
               padding: EdgeInsets.all(30),
            child: Text(
           "0",
           style: TextStyle(
           fontSize: 40,
           color: Colors.black, // text visible on white
                  ),
                ),
              ),
            ),


          // Buttons
          Row(
            children: [
              button("7"), button("8"), button("9"), button("%"),
            ],
          ),
          Row(
            children: [
              button("4"), button("5"), button("6"), button("*"),
            ],
          ),
          Row(
            children: [
              button("1"), button("2"), button("3"), button("-"),
            ],
          ),
          Row(
            children: [button("0"), button("."), button("="), button("+"),
            ],
          ),
         ],
         ),
        ),
      );
   }

    Widget button(String text) {
    return Expanded(
      child: Padding(
   padding: EdgeInsets.all(8),
     child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[800],
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


