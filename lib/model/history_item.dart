class HistoryItem {
  final String calculation;
  final String time;

  HistoryItem({required this.calculation, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'calculation': calculation,
      'time': time,
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      calculation: map['calculation'],
      time: map['time'],
    );
  }
}