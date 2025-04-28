import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventWatcherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _timer;

  void startWatchingEvents() {
    // Schedule the task to run every minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      await _checkAndUpdateEvents();
    });
  }

  void stopWatchingEvents() {
    _timer?.cancel();
  }

  Future<void> _checkAndUpdateEvents() async {
    final now = DateTime.now();

    try {
      // Query to get events that are not marked as done
      QuerySnapshot snapshot = await _firestore
          .collection('events')
          .where('eventIsDone', isEqualTo: false)
          .get();

      for (var doc in snapshot.docs) {
        var eventData = doc.data() as Map<String, dynamic>;
        DateTime eventDate = (eventData['eventDate'] as Timestamp).toDate();

        if (eventDate.isBefore(now)) {
          // Update the event to mark it as done
          await _firestore.collection('events').doc(doc.id).update({
            'eventIsDone': true,
          });
        }
      }
    } catch (e) {
      print("Error updating events: $e");
    }
  }
}
