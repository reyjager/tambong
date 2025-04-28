import 'package:tambong/event/success_page/success_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/themes/theme_service.dart';

class SuccessPageView extends StatelessWidget {
  const SuccessPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SuccessPageViewmodel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            body: const SafeArea(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.greenAccent,
                    size: 130,
                  ),
                  Text("Successfully"),
                ],
              ),
            )),
          );
        });
  }
}
