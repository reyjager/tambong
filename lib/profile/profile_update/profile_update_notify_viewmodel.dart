import 'dart:async';

import 'package:tambong/home/home_view.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ProfileUpdateNotifyViewModel extends BaseViewModel {
  ProfileUpdateNotifyViewModel() {
    Timer(const Duration(seconds: 4), () => goToHome());
  }

  goToHome() {
    Get.offAll(() => HomeView());
  }
}
