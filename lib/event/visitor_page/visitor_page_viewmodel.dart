import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class VisitorPageViewModel extends BaseViewModel {
  final String eventId;
  VisitorPageViewModel({required this.eventId}) {
    init();
  }

  List<Map<String, dynamic>> visitor = [];
  List<Map<String, dynamic>> get allVisitors => visitor;

  init() {
    fetchAttendees();
  }

  Future<void> fetchAttendees() async {
    setBusy(true);
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .collection('eventAttendees')
          .where("position", isEqualTo: "Visitor")
          .where("isAttend", isEqualTo: true)
          .get();

      visitor = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      visitor.sort((a, b) {
        return a['name']
            .toString()
            .toLowerCase()
            .compareTo(b['name'].toString().toLowerCase());
      });
    } catch (e) {
      print('Error fetching attendees: $e');
    }
    setBusy(false);
    notifyListeners();
  }
}
