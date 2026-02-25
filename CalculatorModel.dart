class CalculatorModel {
  String first = "";
  String second = "";
  String op = "";

  void clear() {
    first = "";
    second = "";
    op = "";
  }

  bool get hasFirst => first.isNotEmpty;
  bool get hasSecond => second.isNotEmpty;
  bool get hasOp => op.isNotEmpty;

  String get currentValue => hasOp ? second : first;
}
