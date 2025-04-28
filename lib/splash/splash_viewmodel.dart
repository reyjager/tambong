import 'package:tambong/home/home_view.dart';
import 'package:tambong/splash/ticker_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> positionAnimation;

  final CustomTickerProvider tickerProvider = CustomTickerProvider();

  SplashViewModel() {
    animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(seconds: 3),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    positionAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.addListener(notifyListeners);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => HomeView());
      }
    });
  }

  void startAnimation() {
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
