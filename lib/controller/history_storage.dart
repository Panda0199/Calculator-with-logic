import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/history_item.dart';

class HistoryStorage {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  Future<void> addHistory(HistoryItem item) async {
    if (_auth.currentUser == null) {
      print("NO USER - SKIPPING WRITE");
      return;
    }

    try {
      print("WRITING TO FIRESTORE...");
      print("UID: $_uid");

      await _db.collection('history').add({
        'uid': _uid,
        'calculation': item.calculation,
        'time': item.time,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("WRITE SUCCESS");
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<List<HistoryItem>> loadHistory() async {
    if (_auth.currentUser == null) {
      print("NO USER - LOAD SKIPPED");
      return [];
    }

    final snapshot = await _db
        .collection('history')
        .where('uid', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .get();

    print("DOC COUNT: ${snapshot.docs.length}");

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return HistoryItem(
        calculation: data['calculation'] ?? '',
        time: data['time'] ?? '',
      );
    }).toList();
  }

  Future<void> clearHistory() async {
    if (_auth.currentUser == null) return;

    final snapshot = await _db
        .collection('history')
        .where('uid', isEqualTo: _uid)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    print("HISTORY CLEARED");
  }
}