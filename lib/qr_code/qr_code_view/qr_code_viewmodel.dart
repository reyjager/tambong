import 'package:stacked/stacked.dart';

class QrCodeViewModel extends BaseViewModel {
  final String name;
  final String documentId;
  final String eventId;
  final String eventName;

  QrCodeViewModel(
      {required this.name,
      required this.documentId,
      required this.eventId,
      required this.eventName});

  String get qrData =>
      'Name: $name, Document ID: $documentId, EventId: $eventId, EventName: $eventName';
}
