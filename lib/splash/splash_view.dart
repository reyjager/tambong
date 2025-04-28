import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ThemeService.currentColorScheme.primaryColor,
        body: Center(
          child: AnimatedBuilder(
            animation: model.animationController,
            builder: (context, child) {
              double scale = model.scaleAnimation.value;
              double rotation = model.rotationAnimation.value;
              double position = model.positionAnimation.value;

              return Transform.translate(
                offset: Offset(0, position),
                child: Transform.scale(
                  scale: scale,
                  child: Transform.rotate(
                    angle: rotation,
                    child: Image.asset(
                      'assets/tambong_logo.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
