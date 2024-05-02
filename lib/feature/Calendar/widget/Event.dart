import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
class Event {
  final String title;
  final int color;
  final DateTime date;
  final String id;

  Event(
      {required this.id, required this.title, required this.color, required this.date});


  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      date: data['date'].toDate(),
      title: data['title'],
      color: data['color'],
      id: snapshot.id,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "title": title,
      "description": color
    };
  }
}

