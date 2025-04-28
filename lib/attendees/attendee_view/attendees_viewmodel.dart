// lib/viewmodel/event_attendees_viewmodel.dart

import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventAttendeesViewModel extends BaseViewModel {
  final String eventId;

  EventAttendeesViewModel({required this.eventId}) {
    init();
  }
  // List<EventAttendee> attendees = [];
  bool isLoading = false;

  final List<String> churchList = ["NLFBC", "JUFBC", "NLFBC Thuwal"];
  final List<String> positionList = ["Member", "Visitor", "Pastor", "Worker"];
  List<String> selectedChurches = [];
  List<String> selectedPositions = [];

  List<Map<String, dynamic>> _attendees = [];
  List<Map<String, dynamic>> get eventaAttendees => _attendees;

  init() {
    fetchAttendees();
  }

  Future<void> fetchAttendees() async {
    setBusy(true);
    try {
      print('+++++++evetn Id++++++: $eventId');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .collection('eventAttendees')
          .where("isAttend", isEqualTo: true)
          .get();

      _attendees = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      _attendees.sort((a, b) {
        return a['name']
            .toString()
            .toLowerCase()
            .compareTo(b['name'].toString().toLowerCase());
      });

      print('+++++++++++++: $_attendees');
    } catch (e) {
      print('Error fetching attendees: $e');
    }
    setBusy(false);
    notifyListeners();
  }
}
