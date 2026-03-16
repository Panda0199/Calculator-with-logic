import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});
  @override
  State<ConverterPage> createState() => _ConverterPageState();
}
class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController controller = TextEditingController();
  bool kmToMiles = true;
  String result = "";

  void convert() {
    final v = double.tryParse(controller.text);
    if (v == null) { setState(() { result = ""; }); return; }
    setState(() { result = kmToMiles ? (v * 0.621371).toStringAsFixed(4) : (v / 0.621371).toStringAsFixed(4); });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KM ↔ Mile Converter")),
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
      children: [
      TextField(
      controller: controller,
     keyboardType: const TextInputType.numberWithOptions(decimal: true),
     decoration: const InputDecoration(
     labelText: "How far?",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => convert(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("KM"),
                IconButton(
                icon: Icon(kmToMiles ? Icons.arrow_forward : Icons.arrow_back),
                  onPressed: () {
                    setState(() { kmToMiles = !kmToMiles; });
                    convert();
                  },
                ),
                const Text("Miles"),
              ],
            ),
            const SizedBox(height: 30),
            Text(result, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
