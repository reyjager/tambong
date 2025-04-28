import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/home/home_view.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class MultiStepFormViewModel extends BaseViewModel {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  String? _name;
  String? _position;
  String? _church;
  int _currentStep = 0;
  int get currentStep => _currentStep;
  String? get position => _position;
  String? get church => _church;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updatePosition(String position) {
    _position = position;
    notifyListeners();
  }

  void updateChurch(String church) {
    _church = church;
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<void> updateUser() async {
    print("user id is $userId");
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).update({
        'name': _name,
        'position': _position,
        'church': _church,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("update user to database");
      Get.offAll(() => HomeView());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
