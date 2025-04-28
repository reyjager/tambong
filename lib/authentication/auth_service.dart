// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> emailCheckInUsed({required String email}) async {
    try {
      List<String> signInMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      print('Error checking email: ${e.message}');
      return false;
    }
  }

  static Future<bool?> getCurrentUserIsAdmin() async {
    try {
      // Get the current user ID
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        return null; // User is not signed in
      }

      // Reference to the Firestore users collection, getting only the 'isadmin' field
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        // Print the 'isadmin' field value before returning
        final isAdmin = userDoc.data()?['isadmin'] as bool?;
        print('isAdmin: $isAdmin');
        return isAdmin;
      } else {
        return null; // User document does not exist
      }
    } catch (e) {
      // Handle any errors that occur during the query
      print('Error fetching user isAdmin status: $e');
      return null;
    }
  }
}
