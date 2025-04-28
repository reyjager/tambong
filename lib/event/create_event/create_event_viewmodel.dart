import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/event/event_service/event_service.dart';
import 'package:tambong/event/success_page/success_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class CreateEventViewmodel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EventService eventService = EventService();

  final TextEditingController eventNamectrl = TextEditingController();
  final TextEditingController eventDateCtrl = TextEditingController();
  final TextEditingController eventTimeCtrl = TextEditingController();
  final TextEditingController eventSpeakerCtrl = TextEditingController();
  final TextEditingController eventVenueCtrl = TextEditingController();
  final TextEditingController orgNameCtrl = TextEditingController();
  final TextEditingController orgContactCtrl = TextEditingController();
  final TextEditingController orgEmailCtrl = TextEditingController();

  DateTime? eventDate;
  TimeOfDay? eventTime;

  void setEventDate(DateTime date) {
    eventDate = date;
    eventDateCtrl.text = date.toLocal().toString().split(' ')[0];
    notifyListeners();
  }

  void setEventTime(BuildContext context, TimeOfDay time) {
    eventTime = time;
    eventTimeCtrl.text = time.format(context);
    notifyListeners();
  }

  gotoCreateEvent() async {
    await creatingEvent();
  }

  Future<void> creatingEvent() async {
    setBusy(true);
    try {
      // Create a reference to the Firestore collection
      CollectionReference events =
          FirebaseFirestore.instance.collection('events');

      // Add a new event document without specifying an ID
      DocumentReference docRef = await events.add({
        'eventName': eventNamectrl.text,
        'eventDate': eventDateCtrl.text,
        'eventTime': eventTimeCtrl.text,
        'eventSpeaker': eventSpeakerCtrl.text.isEmpty
            ? "To be updated"
            : eventSpeakerCtrl.text,
        'eventVenue': eventVenueCtrl.text.isEmpty
            ? "To be Announced"
            : eventVenueCtrl.text,
        'eventIsDone': false,
        'userId': _auth.currentUser!.uid,
        'isCancel': false,
        'orgName': orgNameCtrl.text,
        'orgContact': orgContactCtrl.text,
        'orgEmail': orgEmailCtrl.text,
        'docId': "", // Initially set to an empty string
      });

      // Update the document with the generated docId
      await docRef.update({'docId': docRef.id});

      gotoSuccessPage();
      Get.back();
    } catch (e) {
      throw Exception("Error in creating Event ${e}");
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  gotoSuccessPage() {
    Get.to(() => const SuccessPageView());
  }
}
