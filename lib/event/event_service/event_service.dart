import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/model/event_model.dart';

class EventService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  final List<Event> historyEvents = [];
  final List<Event> upComingEvents = [];
  final List<Event> allEvents = [];

  User? get currentUser => _auth.currentUser;

  Future<List<Event>> getAllEvents() async {
    QuerySnapshot snapshot = await db.collection("events").get();

    for (var data in snapshot.docs) {
      Event event = Event(
          eventName: data["eventName"],
          eventDate: data["eventDate"],
          eventTime: data['eventTime'],
          eventSpeaker: data["eventSpeaker"],
          docId: data['docId'],
          eventVenue: data["eventVenue"],
          eventIsDone: data["eventIsDone"],
          userId: data["userId"],
          isCancel: data["isCancel"],
          orgName: data["orgName"],
          orgContact: data["orgContact"],
          orgEmail: data["orgEmail"]);

      allEvents.add(event);
    }

    return allEvents;
  }

  Future<List<Event>> getHistoryEvents() async {
    QuerySnapshot snapshot = await db
        .collection("events")
        .where("eventIsDone", isEqualTo: true)
        .get();
    // print("snapshot${snapshot}");
    for (var doc in snapshot.docs) {
      String eventName = doc["eventName"];
      String eventDate = doc["eventDate"];
      String eventTime = doc['eventTime'];
      String eventSpeaker = doc["eventSpeaker"];
      bool eventIsDone = doc["eventIsDone"];
      bool eventIsCancel = doc["isCancel"];
      String docId = doc["docId"];

      Event event = Event(
        eventName: eventName,
        eventDate: eventDate,
        eventTime: eventTime,
        eventSpeaker: eventSpeaker,
        eventIsDone: eventIsDone,
        isCancel: eventIsCancel,
        docId: docId,
      );

      historyEvents.add(event);
    }

    return historyEvents;
  }

  Future<List<Event>> getUpComingEvents() async {
    QuerySnapshot snapshot = await db
        .collection("events")
        .where("eventIsDone", isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      String eventName = doc["eventName"] ?? "";
      String eventDate = doc["eventDate"] ?? "";
      String eventTime = doc['eventTime'] ?? "";
      String eventSpeaker = doc["eventSpeaker"] ?? "";
      bool eventIsDone = doc["eventIsDone"] ?? "";
      bool eventIsCancel = doc["isCancel"] ?? "";
      String docId = doc.id;

      Event event = Event(
        eventName: eventName,
        eventDate: eventDate,
        eventTime: eventTime,
        eventSpeaker: eventSpeaker,
        eventIsDone: eventIsDone,
        isCancel: eventIsCancel,
        docId: docId,
      );

      upComingEvents.add(event);
    }
    return upComingEvents;
  }

  Future<void> addEvent(Event event) async {
    try {
      // Step 1: Add the document to Firestore

      print("now creating event");
      DocumentReference docRef = await db.collection("events").add({
        'userId': currentUser!.uid,
        'orgName': event.orgName,
        'orgEmail': event.orgEmail,
        'orgContact': event.orgContact,
        'eventName': event.eventName,
        'eventVenue': event.eventVenue,
        'eventDate': event.eventDate,
        'eventTime': event.eventTime,
        'eventSpeaker': event.eventSpeaker,
        'eventIsDone': event.eventIsDone,
        'isCancel': event.isCancel,
        'docId': event.docId,
      });

      String docId = docRef.id;

      await docRef.update({
        'docId': docId,
      });
    } catch (e) {
      throw Exception('Failed to add event: $e');
    }
  }

  Future<void> updateEvent(String id, Event event) async {
    try {
      await db.collection("events").doc(id).update({
        'eventName': event.eventName,
        'eventDate': event.eventDate,
        'eventTime': event.eventTime,
        'eventSpeaker': event.eventSpeaker,
      });
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await db.collection("events").doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  Future<void> markEventAsDone(String docId) async {
    try {
      await db.collection("events").doc(docId).update({
        'eventIsDone': true,
      });
    } catch (e) {
      throw Exception('Failed to mark event as done: $e');
    }
  }
}
