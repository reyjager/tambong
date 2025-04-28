// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/attendees/attendee_view/attendees_view.dart';
import 'package:tambong/authentication/auth_service.dart';
import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/event/success_page/success_page_view.dart';
import 'package:tambong/model/event_model.dart';
import 'package:tambong/programme/html_view.dart';
import 'package:tambong/qr_code/qr_code_view/qr_code_view.dart';
import 'package:tambong/qr_code/qr_scanner/qr_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class MenuEventViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final Event event;
  MenuEventViewModel({
    required this.event,
  }) {
    fetchAttendeesUnderByUser();
    checkUserIsAdmin();
    notifyListeners();
  }

  String successMessage = "";
  String notificationMessage = "";
  Position selectedPosition = Position.Member;
  Church selectedChurch = Church.NLFBC;
  bool hasArrived = false;

  List<Position> get positionOptions => Position.values;
  List<Church> get chuchOptions => Church.values;

  List<Map<String, dynamic>> attendees = [];
  List<Map<String, dynamic>> get attendeesUnderUserId => attendees;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController churchController = TextEditingController();
  bool isAttend = false;

  bool? _isAdmin = false;
  bool? get isAdmin => _isAdmin;

  Future checkUserIsAdmin() async {
    _isAdmin = await AuthenticationService.getCurrentUserIsAdmin();
    print('888888888888888888888888 $_isAdmin');
    notifyListeners();
  }

  gotoRegisterEvent() {
    registerForEvent();
  }

  Future<void> registerForEvent() async {
    // print("name ${nameController.text} going to enroll");
    try {
      DocumentReference eventDocRef =
          _firestore.collection('events').doc(event.docId);

      // Check if the name already exists in the eventAttendees collection
      QuerySnapshot existingAttendees = await eventDocRef
          .collection('eventAttendees')
          .where('name', isEqualTo: nameController.text)
          .get();

      if (existingAttendees.docs.isNotEmpty) {
        // Handle the case where the name already exists
        notificationMessage =
            "${nameController.text} is already enrolled in ${event.eventName}.";
        print("name ${nameController.text} is already enrolled");
      } else {
        // Add the new attendee
        await eventDocRef.collection('eventAttendees').add({
          'eventId': event.docId,
          'name': nameController.text,
          'isAttend': isAttend,
          'position': selectedPosition.toString(),
          'church': selectedChurch.toString(),
          'userId': userId.toString(),
        });

        successMessage =
            "${nameController.text} is successfully enrolled in ${event.eventName}.";
        print("name ${event.eventName} enrolled");
        successfullyRegister();
      }

      // Notify listeners if needed
      notifyListeners();
    } catch (e) {
      // Handle errors appropriately
      print("Error registering for event: $e");
    }
  }

  gotoAttendeesView(eventDocId) {
    String eventId = eventDocId.docId;
    Get.to(() => AttendeesView(eventId: eventId));
  }

  void updateSelectedPosition(Position? newPosition) {
    if (newPosition != null) {
      selectedPosition = newPosition;
      notifyListeners();
    }
  }

  void updateSelectedChurch(Church? newChurch) {
    if (newChurch != null) {
      selectedChurch = newChurch;
      notifyListeners();
    }
  }

  updateHasArrived(bool value) {
    hasArrived = value;
    notifyListeners();
  }

  successfullyRegister() {
    nameController.clear();
    Get.to(() => const SuccessPageView());
  }

  gotoArrived() async {
    DocumentReference eventDocRef =
        _firestore.collection('events').doc(event.docId);

    // Check if the name already exists in the eventAttendees collection
    QuerySnapshot existingAttendees = await eventDocRef
        .collection('eventAttendees')
        .where('name', isEqualTo: nameController.text)
        .get();

    if (existingAttendees.docs.isNotEmpty) {
      // Handle the case where the name already exists
      notificationMessage =
          "${nameController.text} is already enrolled in ${event.eventName}.";
      // print("name ${nameController.text} is already enrolled");
    } else {
      // Add the new attendee
      await eventDocRef.collection('eventAttendees').add({
        'eventId': event.docId,
        'name': nameController.text,
        'isAttend': hasArrived, // Capture the value of hasArrived
        'position': selectedPosition.toString(),
        'church': selectedChurch.toString(),
        'userId': userId.toString(),
      });

      successfullyRegister();
    }

    // Notify listeners if needed
    notifyListeners();
  }

  Future<void> fetchAttendeesUnderByUser() async {
    setBusy(true);
    if (userId == null) {
      // print('[DEBUG]Error: userId is null');
      return;
    }
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(event.docId)
          .collection('eventAttendees')
          .where("userId", isEqualTo: userId)
          .where("isAttend", isEqualTo: false)
          .get();

      attendees = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['docId'] = doc.id;
        return data;
      }).toList();

      attendees.sort((a, b) {
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

  gotoQRCodeView(name, attendeeId, eventId, eventName) {
    Get.to(() => QrCodeView(
          name: name,
          documentId: attendeeId,
          eventId: eventId,
          eventName: eventName,
        ));
  }

  gototQRCodeScanner() {
    // print("WELCOME========SCAN NOW");
    Get.to(() => QRScannerView());
  }

  gotoHtmlView() {
    String eventName = event.eventName;
    Get.to(() => HtmlView(eventName: eventName));
  }
}
