import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/CalculatorController.dart';
import 'converter_page.dart';
import 'history_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

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
  void initState() {
    super.initState();
    startApp();
  }

  Future<void> startApp() async {
    await controller.loadHistory();
    setState(() {});
  }

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
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(controller: controller),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConverterPage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40, top: 40),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(30),
                child: ValueListenableBuilder<String>(
                  valueListenable: controller.display,
                  builder: (context, value, _) {
                    return Text(
                      value,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                button("C"),
                button("O"),
                button("L"),
                button("D"),
              ],
            ),
            Row(
              children: [
                button("7"),
                button("8"),
                button("9"),
                button("%"),
              ],
            ),
            Row(
              children: [
                button("4"),
                button("5"),
                button("6"),
                button("*"),
              ],
            ),
            Row(
              children: [
                button("1"),
                button("2"),
                button("3"),
                button("-"),
              ],
            ),
            Row(
              children: [
                button("0"),
                button("."),
                button("="),
                button("+"),
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
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: (text == "O" || text == "L" || text == "D")
              ? null
              : () async {
            await controller.press(text);
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}