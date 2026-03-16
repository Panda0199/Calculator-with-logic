import 'package:flutter/material.dart';
import 'controller/CalculatorController.dart';

class HistoryPage extends StatefulWidget {
  final CalculatorController controller;

  const HistoryPage({super.key, required this.controller});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            onPressed: () async {
              await widget.controller.clearHistory();
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: widget.controller.history.isEmpty
          ? const Center(child: Text("No history"))
          : ListView.builder(
        itemCount: widget.controller.history.length,
        itemBuilder: (context, index) {
          final item = widget.controller.history[index];
          return ListTile(
            title: Text(item.calculation),
            subtitle: Text(item.time),
          );
        },
      ),
    );
  }
}