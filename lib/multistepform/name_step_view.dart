import 'package:tambong/multistepform/multistep_form_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NameStepView extends ViewModelWidget<MultiStepFormViewModel> {
  @override
  Widget build(BuildContext context, MultiStepFormViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: TextField(
              onChanged: viewModel.updateName,
              decoration:
                  const InputDecoration(labelText: 'Enter your complete Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: CustomElevatedButton(
                backgroundColor: ThemeService.currentColorScheme.primaryColor,
                onPressed: viewModel.nextStep,
                text: "Next"),
          ),
        ],
      ),
    );
  }
}
