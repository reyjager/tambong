import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/home/home_view.dart';
import 'package:tambong/model/app_user_model.dart';
import 'package:tambong/profile/profile_update/profile_update_notify_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import '../profile_service/profile_service.dart';

class CompleteProfileViewModel extends BaseViewModel {
  final ProfileService profileService;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final email = FirebaseAuth.instance.currentUser?.email;
  bool isEdit;
  final List<AppUser> _users = [];
  AppUser? _user;

  List<AppUser> get users => _users;
  AppUser? get user => _user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController churchController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();

  CompleteProfileViewModel({required this.isEdit})
      : profileService = ProfileService() {
    if (isEdit) {
      fetchUserById(userId!);
    } else {
      fetchUser();
    }
    notifyListeners();
  }

  Position selectedPosition = Position.Visitor;

  List<Position> get positionOptions => Position.values.toList();

  void updateSelectedPosition(Position? newPosition) {
    if (newPosition != null) {
      selectedPosition = newPosition;
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    setBusy(true);
    try {
      print("Fetching user with ID: $userId");
      _user = await profileService.getUserDataById(userId!, email!);
      if (_user != null) {
        print("User fetched: ${_user!.completeName}");
      } else {
        print("No user found with ID: $userId");
      }
    } catch (e) {
      print("Error fetching user: $e");
    } finally {
      setBusy(false);
      notifyListeners();
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchUserById(String userId) async {
    setBusy(true);
    _user = await profileService.getUserDataById(userId, email!);
    if (_user != null) {
      nameController.text = _user?.completeName ?? "";
      ageController.text = _user?.age ?? "";
      churchController.text = _user?.church ?? "";
      positionController.text = _user?.position ?? "";
      addressController.text = _user?.address ?? "";
      mobileNoController.text = _user?.mobileNo ?? "";
      selectedPosition =
          Position.values.firstWhere((e) => e.toString() == _user!.position);
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> completeRegistration(String userId) async {
    setBusy(true);

    try {
      // final firstName = firstNameController.text;
      // final middleName = middleNameController.text;
      // final lastName = lastNameController.text;
      // final age = ageController.text;
      // final churchName = churchController.text;
      // final position = selectedPosition.toString();
      // final address = addressController.text;
      // final mobileNo = mobileNoController.text;

      final registerUser = AppUser(
        userId: userId,
        email: _user?.email ?? '',
        completeName: nameController.text,
        age: ageController.text,
        church: churchController.text,
        position: selectedPosition.toString(),
        address: addressController.text,
        mobileNo: mobileNoController.text,
        isadmin: false,
      );

      await profileService.updateUserProfile(userId, registerUser);

      Get.to(() => const ProfileUpdateViewResponse());
    } catch (e) {
      print("Error during registration: $e");
    } finally {
      setBusy(false);
    }
  }

  gotoEditProfile() {
    isEdit = true;
    notifyListeners();
    print("isEdit is ${isEdit}");
  }

  void gotoUpdateUserProfile(String userId) {
    if (_user != null) {
      profileService.updateUserProfile(userId, _user!);
    }
  }

  goToHomePage() {
    Get.offAll(HomeView());
  }
}
