import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/home/home_view.dart';
import 'package:tambong/profile/profile_service/profile_service.dart';

class SignInViewmodel extends BaseViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ProfileService profileService = ProfileService();
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;

  bool obscurePassword = true;
  String? errorMessage;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  navigateToRegister() {}

  Future<void> signIn(String email, String password) async {
    try {
      setBusy(true);
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Get.to(() => HomeView());
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}
