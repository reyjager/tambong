// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

class QRScannerViewModel extends BaseViewModel {
  QRScannerViewModel({
    this.messageStatus,
  });
  String? messageStatus;
  String? get message => messageStatus;
  String? _successMessage;
  String? get successMessage => _successMessage;

  Future handleScan(Barcode scanData) async {
    final scannedData = scanData.code ?? '';
    final dataParts = scannedData.split(',');
    print(" =====000000===== ${dataParts}");
    if (dataParts.length == 4) {
      // final attendeeName = dataParts[0].split(': ')[1];
      final attendeeId = dataParts[1].split(': ')[1];
      final eventId = dataParts[2].split(': ')[1];

      print("${attendeeId} ======1====== ${eventId}");

      setBusy(true);
      await updateAttendanceStatus(eventId, attendeeId);
      notifyListeners();
      setBusy(false);
    } else {
      messageStatus = 'Invalid QR code format';
      notifyListeners();
    }
  }

  Future<void> updateAttendanceStatus(String eventId, String attendeeId) async {
    try {
      // Reference to the specific attendee document in the eventAttendees collection
      final attendeeDocRef = FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .collection('eventAttendees')
          .doc(attendeeId);

      print("${attendeeId} ======3====== ${eventId}");
      // Get the attendee document
      final attendeeSnapshot = await attendeeDocRef.get();

      // Check if the document exists
      if (attendeeSnapshot.exists) {
        // Get the current value of isAttend
        bool isAttend = attendeeSnapshot.data()?['isAttend'] ?? false;
        print("${attendeeId} ======4====== ${eventId}");

        // Update isAttend to true if it's currently false
        if (!isAttend) {
          await attendeeDocRef.update({'isAttend': true});
          _successMessage = "Verified log entry, WELCOME";
          print("${attendeeId} ======5====== ${eventId}");
          print('Attendance marked as true.');
        } else {
          messageStatus = "Logged has done more than once";
          print('Already arrived.');
          print("${attendeeId} ======6====== ${eventId}");
        }
      } else {
        messageStatus = "Attendee document not found";
        print('Attendee document not found.');
        print("${attendeeId} ======7====== ${eventId}");
      }
    } catch (e) {
      messageStatus = "Error updating attendance";
      print('Error updating attendance: $e');
      print("${attendeeId} ======8====== ${eventId}");
    }
  }
}
