import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tambong/event/edit_event/edit_event_view.dart';
import 'package:tambong/event/event_service/event_service.dart';
import 'package:tambong/event/visitor_page/visitor_page_view.dart';
import 'package:tambong/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EventInfoViewmodel extends BaseViewModel {
  final Event event;
  final EventService eventService = EventService();
  Map<String, Map<String, int>> churchData = {};
  int visitorCount = 0;
  List<Map<String, dynamic>> attendees = [];

  EventInfoViewmodel({required this.event}) {
    print("[DEBUG] eventId is ====== $event");
    init();
  }

  Map<String, dynamic> eventData = {};
  Map<String, dynamic> get eventdata => eventData;
  final Map<String, dynamic> _eventInfo = {};
  Map<String, dynamic> get eventInfo => _eventInfo;

  init() async {
    // await getDataInformation();
    await fetchAttendees();
    await getDataInformation();
    print("rey");
  }

  fetchAttendees() async {
    print("[DEBUG] eventId is +++++++++  yes $event");
    print("[DEBUG] eventId is +++++++++  yes ${event.docId}");

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(event.docId)
        .collection('eventAttendees')
        .where("isAttend", isEqualTo: true)
        .get();

    attendees =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    print("[DEBUG] thisiiisisi $attendees");
    notifyListeners();
  }

  deleteEvent(eventId) async {
    bool confirmed = await Get.defaultDialog(
      title: 'Confirm Deletion',
      middleText: 'Are you sure you want to delete this event?',
      confirm: TextButton(
        onPressed: () => Get.back(result: true),
        child: const Text('Yes'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(result: false),
        child: const Text('No'),
      ),
    );

    if (confirmed) {
      await eventService.deleteEvent(eventId);
      Get.back();
    }
  }

  editEventInformation(event) async {
    Get.offAll(() => EditEventView(event: event));
  }

  Future<Map<String, dynamic>> getDataInformation() async {
    var db = FirebaseFirestore.instance;
    final List<String> churchList = ["NLFBC", "JUFBC", "NLFBC Thuwal"];
    final List<String> positionList = ["Member", "Visitor", "Pastor", "Worker"];

    churchData = {
      for (var church in churchList)
        church: {for (var position in positionList) position: 0}
    };

    int totalAttendees = 0;
    int otherChurchCount = 0;

    int nlfbcTotal = 0;
    int nlfbcVisitor = 0;
    int jufbcTotal = 0;
    int jufbcVisitor = 0;
    int nlfbcTTotal = 0;
    int nlfbcTVisitor = 0;

    try {
      QuerySnapshot snapshot = await db
          .collection('events')
          .doc(event.docId)
          .collection('eventAttendees')
          .where("isAttend", isEqualTo: true)
          .get();

      attendees = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      print("++++++++++++++++ ${attendees}");

      for (var data in attendees) {
        String church = data['church'] ?? 'Other';
        String position = data['position'] ?? 'Unknown';
        bool isAttend = data['isAttend'] ?? false;

        if (isAttend) {
          totalAttendees++;

          if (church == "NLFBC") {
            nlfbcTotal++;
            if (position == "Visitor") {
              nlfbcVisitor++;
              visitorCount++;
            }
          } else if (church == "JUFBC") {
            jufbcTotal++;
            if (position == "Visitor") {
              jufbcVisitor++;
              visitorCount++;
            }
          } else if (church == "NLFBC Thuwal") {
            nlfbcTTotal++;
            if (position == "Visitor") {
              nlfbcTVisitor++;
              visitorCount++;
            }
          } else {
            otherChurchCount++;
          }

          if (churchList.contains(church)) {
            if (positionList.contains(position)) {
              churchData[church]![position] =
                  (churchData[church]![position] ?? 0) + 1;
            }
          }
        }
      }

      eventData = {
        'totalAttendees': totalAttendees,
        'otherChurchCount': otherChurchCount,
        'nlfbcTotal': nlfbcTotal,
        'nlfbcVisitorTotal': nlfbcVisitor,
        'jufbcTotal': jufbcTotal,
        'jufbcVisitorTotal': jufbcVisitor,
        'nlfbcTTotal': nlfbcTTotal,
        'nlfbcTVisitorTotal': nlfbcTVisitor,
        'visitorTotal': visitorCount,
      };

      notifyListeners();
      return eventData;
    } catch (e) {
      print("Error getting attendee data: $e");
      return {};
    }
  }

  gotoVistorPage(eventId) {
    Get.to(() => VisitorPageView(eventId: eventId));
  }
}
