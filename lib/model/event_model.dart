class Event {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventSpeaker;
  final String docId;
  String? eventVenue;
  String? userId;
  String? orgName;
  String? orgContact;
  String? orgEmail;
  bool? eventIsDone;
  bool? isCancel;

  Event({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventSpeaker,
    required this.docId,
    this.eventVenue,
    this.userId,
    this.orgName,
    this.orgContact,
    this.orgEmail,
    this.eventIsDone,
    this.isCancel,
  });

  @override
  String toString() {
    return 'Event(docId: $docId, eventName: $eventName, eventDate: $eventDate, eventTime: $eventTime, eventSpeaker: $eventSpeaker)';
  }
}
