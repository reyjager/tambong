// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:tambong/authentication/auth_service.dart';
import 'package:tambong/authentication/sign_in/signin_view.dart';
import 'package:tambong/event/event_view/event_view.dart';
import 'package:tambong/profile/profile_views/profile_view.dart';

class DrawerViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthenticationService _authenticationService = AuthenticationService();

  DrawerViewModel() {
    checkUserIsAdmin();
  }
  bool? _isAdmin;
  bool? get isAdmin => _isAdmin;

  Future checkUserIsAdmin() async {
    _isAdmin = await AuthenticationService.getCurrentUserIsAdmin();
    notifyListeners();
  }

  User? get currentUser => _auth.currentUser;

  String? get currentUserEmail {
    return currentUser?.email;
  }

  String get currentUserName {
    if (currentUser?.displayName == null || currentUser!.displayName!.isEmpty) {
      return 'User Name';
    }
    return currentUser!.displayName!;
  }

  void signOut() async {
    try {
      await _auth.signOut();

      _authenticationService.signOut();
      Get.offAll(() => SignInView());
    } catch (e) {
      print("[DEBUG] Error signing out: $e");
    }
  }

  Future<void> navigateToProfile() async {
    Get.back();
    try {
      Get.to(() => ProfileView());
    } catch (e) {
      print("[DEBUG] Error navigating to profile: $e");
    }
  }

  void navigateToEvent() {
    Get.back();
    Get.to(() => EventView());
  }

  void navigateToQRCode() {
    Get.back();
    // Implement QR Code navigation if needed
    Get.to(() => () {});
  }

  void navigateToSettings() {
    Get.back();
    // Implement navigation to Settings
  }

  void navigateToPolicy() {
    Get.back();
    // Implement navigation to Policy
  }

  void navigateToContacts() {
    Get.back();
    // Implement navigation to Contacts
  }
}
