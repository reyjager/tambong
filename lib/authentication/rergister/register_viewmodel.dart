// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/authentication/sign_in/signin_view.dart';
import 'package:tambong/multistepform/multi_step_view_form.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import 'package:tambong/model/app_user_model.dart';
import 'package:tambong/profile/profile_service/profile_service.dart';

class RegisterViewModel extends BaseViewModel {
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

  Future<void> signUp(String email, String password) async {
    setBusy(true);
    errorMessage = null;
    notifyListeners();

    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        // Save user details to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'userId': user.uid,
          'email': email,
          'completeName': "",
          'age': "",
          'church': "",
          'position': "Member",
          'address': "",
          'image': "",
          'mobileNo': "",
          'isadmin': false,
        });

        Get.offAll(() => MultiStepFormView());
      } else {
        errorMessage = 'User creation failed';
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = 'An unknown error occurred';
    }

    setBusy(false);
    notifyListeners();
  }

  void navigateToSignIn() {
    Get.offAll(() => SignInView());
  }

  Future<bool> checkUserNameData() async {
    try {
      AppUser? user = await profileService.getUserDataById(userId!, email!);
      if (user != null && user.completeName != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching user data: $e');
      return false;
    }
  }
}
