import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/model/app_user_model.dart';
import 'package:tambong/profile/profile_service/profile_service.dart';
import 'package:tambong/profile/profile_update/profile_update_notify_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EditProfileViewModel extends BaseViewModel {
  AppUser? user;

  EditProfileViewModel({required this.user}) {
    initializeTextField();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController churchController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();

  Position selectedPosition = Position.Member;

  List<Position> get positionOptions => Position.values.toList();

  void updateSelectedPosition(Position? newPosition) {
    if (newPosition != null) {
      selectedPosition = newPosition;
      notifyListeners();
    }
  }

  Future<void> updateUserInformation() async {
    setBusy(true);
    try {
      final completeName = nameController.text;
      final age = ageController.text;
      final churchName = churchController.text;
      final position = selectedPosition.toString().split(".").last;
      final address = addressController.text;
      final mobileNo = mobileNoController.text;

      final updateInfo = AppUser(
        userId: user!.userId,
        email: user!.email,
        completeName: completeName,
        age: age,
        church: churchName,
        position: position,
        address: address,
        mobileNo: mobileNo,
      );
      await ProfileService().updateUserProfile(user!.userId, updateInfo);

      Get.off(() => const ProfileUpdateViewResponse());
    } catch (e) {
      print("Error during registration: $e");
    } finally {
      setBusy(false);
    }
  }

  Future<void> initializeTextField() async {
    setBusy(true);

    nameController.text = user!.completeName;
    ageController.text = user?.age ?? "";
    churchController.text = user?.church ?? "";
    positionController.text = user?.position ?? "";
    addressController.text = user?.address ?? "";
    mobileNoController.text = user?.mobileNo ?? "";
    // selectedPosition =
    //     Position.values.firstWhere((e) => e.toString() == user!.position);

    try {
      selectedPosition = Position.values.firstWhere(
          (e) => e.toString() == user!.position,
          orElse: () => Position.Member // Provide a default value
          );
    } catch (e) {
      print("Error setting position: $e");
      selectedPosition = Position.Member; // Fallback to a default value
    }

    setBusy(false);
    notifyListeners();
  }

  goBackPage() {
    Get.back();
  }
}
