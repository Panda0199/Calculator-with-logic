import 'package:flutter/foundation.dart';
import '../model/CalculatorModel.dart';

class CalculatorController {
  final CalculatorModel _m = CalculatorModel();

  final ValueNotifier<String> display = ValueNotifier<String>("0");

  void press(String text) {
    if (text == "C") {
      _clearAll();
      return;
    }

    if (text == "=") {
      _calculate();
      return;
    }

    if (_isOperator(text)) {
      _setOperator(text);
      return;
    }

    _appendNumber(text);
  }

  bool _isOperator(String s) => s == "+" || s == "-" || s == "*" || s == "%";

  void _clearAll() {
    _m.clear();
    display.value = "0";
  }

  void _setOperator(String op) {
    if (!_m.hasFirst) _m.first = "0";
    if (_m.hasOp && _m.hasSecond) {
      _calculate();

    }
    _m.op = op;
    _updateDisplayFromModel();
  }
  void _appendNumber(String ch) {
    if (ch == ".") {
      final current = _m.hasOp ? _m.second : _m.first;
      if (current.contains(".")) return;
      if (current.isEmpty) {
        _writeToCurrent("0.");
        _updateDisplayFromModel();
        return;
      }
    }

    final current = _m.hasOp ? _m.second : _m.first;
    if (current == "0" && ch != ".") {
      _setCurrent(ch);
      _updateDisplayFromModel();
      return;
    }
    _writeToCurrent(ch);
    _updateDisplayFromModel();
  }
  void _writeToCurrent(String s) {
    if (_m.hasOp) {
      _m.second += s;
    } else {
      _m.first += s;
    }
  }
  void _setCurrent(String s) {
    if (_m.hasOp) {
      _m.second = s;
    } else {
      _m.first = s;
    }
  }
  void _calculate() {
    // Need: first number, operator, second number
    if (!_m.hasFirst || !_m.hasOp || !_m.hasSecond) {
      _updateDisplayFromModel();
      return;
    }
    final a = double.tryParse(_m.first);
    final b = double.tryParse(_m.second);

    if (a == null || b == null) {
      display.value = "Error";
      _m.clear();
      return;
    }
    double result;

    switch (_m.op) {
      case "+":
        result = a + b;
        break;
      case "-":
        result = a - b;
        break;
      case "*":
        result = a * b;
        break;
      case "%":
        if (b == 0) {
          display.value = "Error";
          _m.clear();
          return;
        }
        result = a / b;
        break;
      default:
        return;
    }
    final resultText = _format(result);
    display.value = resultText;

    _m.first = resultText;
    _m.second = "";
    _m.op = "";
  }

  String _format(double v) {
    final s = v.toString();
    if (s.endsWith(".0")) return s.substring(0, s.length - 2);
    return s;
  }

  void _updateDisplayFromModel() {
    if (!_m.hasFirst && !_m.hasSecond) {
      display.value = "0";
      return;
    }
    display.value = _m.hasOp ? (_m.second.isEmpty ? "0" : _m.second) : _m.first;
  }
  void dispose() {
    display.dispose();
  }
}
