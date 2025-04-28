import 'package:tambong/multistepform/multistep_form_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChurchStepView extends ViewModelWidget<MultiStepFormViewModel> {
  @override
  Widget build(BuildContext context, MultiStepFormViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Select your Church',
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.withOpacity(.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheckboxListTile(
                  title: const Text('Newness Jeddah'),
                  value: viewModel.church == 'NLFBCJ',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updateChurch('NLFBCJ');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('Newness Thuwal'),
                  value: viewModel.church == 'NLFBCT',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updateChurch('NLFBCT');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('JUFBC'),
                  value: viewModel.church == 'JUFBC',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updateChurch('JUFBC');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('other'),
                  value: viewModel.church == 'other',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updateChurch('other');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomElevatedButton(
                backgroundColor: ThemeService.currentColorScheme.primaryColor,
                onPressed: viewModel.previousStep,
                text: "Back",
              ),
              CustomElevatedButton(
                backgroundColor: ThemeService.currentColorScheme.primaryColor,
                onPressed: viewModel.nextStep,
                text: "Next",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
