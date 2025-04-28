import 'package:tambong/event/event_service/event_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/model/event_model.dart';

class EditEventViewModel extends BaseViewModel {
  final EventService eventService = EventService();
  final Event event;

  TextEditingController eventNamectrl;
  TextEditingController eventDateCtrl;
  TextEditingController eventTimeCtrl;
  TextEditingController eventSpeakerCtrl;

  DateTime? eventDate;
  TimeOfDay? eventTime;

  EditEventViewModel(this.event)
      : eventNamectrl = TextEditingController(text: event.eventName),
        eventDateCtrl = TextEditingController(text: event.eventDate),
        eventTimeCtrl = TextEditingController(text: event.eventTime),
        eventSpeakerCtrl = TextEditingController(text: event.eventSpeaker);

  void setEventDate(DateTime date) {
    eventDate = date;
    notifyListeners();
    eventDateCtrl.text = date.toLocal().toString().split(' ')[0];
  }

  void setEventTime(BuildContext context, TimeOfDay time) {
    eventTime = time;
    notifyListeners();
    eventTimeCtrl.text = time.format(context);
  }

  Future<void> gotoUpdateEvent() async {
    setBusy(true);

    try {
      Event updatedEvent = Event(
        eventName: eventNamectrl.text.isNotEmpty ? eventNamectrl.text : '',
        eventDate: eventDateCtrl.text.isNotEmpty ? eventDateCtrl.text : '',
        eventTime: eventTimeCtrl.text.isNotEmpty ? eventTimeCtrl.text : '',
        eventSpeaker:
            eventSpeakerCtrl.text.isNotEmpty ? eventSpeakerCtrl.text : '',
        docId: event.docId,
      );

      await eventService.updateEvent(event.userId!, updatedEvent);
    } catch (e) {
      print('Error updating event: $e');
    } finally {
      setBusy(false);
    }
  }
}
