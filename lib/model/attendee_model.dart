import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EventAttendee {
  final String church;
  final String eventId;
  final bool isAttend;
  final String name;
  final String position;
  final String userId;

  EventAttendee({
    required this.church,
    required this.eventId,
    required this.isAttend,
    required this.name,
    required this.position,
    required this.userId,
  });

  @override
  String toString() {
    return 'EventAttendee(church: $church, eventId: $eventId, isAttend: $isAttend, name: $name, position: $position, userId: $userId)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'church': church,
      'eventId': eventId,
      'isAttend': isAttend,
      'name': name,
      'position': position,
      'userId': userId,
    };
  }

  factory EventAttendee.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return EventAttendee(
      church: data['church'] ?? '',
      eventId: data['eventId'] ?? '',
      isAttend: data['isAttend'] ?? false,
      name: data['name'] ?? '',
      position: data['position'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
  factory EventAttendee.fromMap(Map<String, dynamic> map) {
    return EventAttendee(
      church: map['church'] as String,
      eventId: map['eventId'] as String,
      isAttend: map['isAttend'] as bool,
      name: map['name'] as String,
      position: map['position'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventAttendee.fromJson(String source) =>
      EventAttendee.fromMap(json.decode(source) as Map<String, dynamic>);
}
