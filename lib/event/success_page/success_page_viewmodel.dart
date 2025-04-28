import 'dart:async';

import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SuccessPageViewmodel extends BaseViewModel {
  SuccessPageViewmodel() {
    Timer(const Duration(seconds: 4), () => Get.back());
  }
}
