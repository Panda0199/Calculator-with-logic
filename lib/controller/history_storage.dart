import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/history_item.dart';

class HistoryStorage {
  static const String key = 'calculator_history';

  Future<void> saveHistory(List<HistoryItem> history) async {
    final prefs = await SharedPreferences.getInstance();
    final list = history.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList(key, list);
  }

  Future<List<HistoryItem>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    return list
        .map((item) => HistoryItem.fromMap(jsonDecode(item)))
        .toList();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}