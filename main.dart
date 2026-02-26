import 'package:flutter/material.dart';
import 'controller/CalculatorController.dart';
import 'converter_page.dart';

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

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculatorController controller = CalculatorController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConverterPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
      padding: EdgeInsets.only(bottom: 40, top: 40),
      child: Column(
      children: [
      Expanded(
         child: Container(
         color: Colors.white,
        alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(30),
         child: ValueListenableBuilder<String>(
           valueListenable: controller.display,
          builder: (context, value, _) {
           return Text(
           value,
           style: TextStyle(
           fontSize: 40,
           color: Colors.black,
           ),
           );
            },
             ),
           ),
            ),
        Row(
          children: [button("C"), button("O"), button("L"), button("D"),
          ],
        ),


        Row(
              children: [
                button("7"), button("8"), button("9"), button("%"), // % = Clear
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
              children: [
                button("0"), button("."), button("="), button("+"),
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
          onPressed: () {
            controller.press(text);
          },
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
