import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/multistepform/multistep_form_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';

class PositionStepView extends ViewModelWidget<MultiStepFormViewModel> {
  @override
  Widget build(BuildContext context, MultiStepFormViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Select your position',
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
                  title: const Text('Member'),
                  value: viewModel.position == 'Member',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updatePosition('Member');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('Pastor'),
                  value: viewModel.position == 'Pastor',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updatePosition('Pastor');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('Visitor'),
                  value: viewModel.position == 'Visitor',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updatePosition('Visitor');
                    }
                  },
                ),
                CheckboxListTile(
                  title: const Text('Worker'),
                  value: viewModel.position == 'Worker',
                  onChanged: (bool? value) {
                    if (value == true) {
                      viewModel.updatePosition('Worker');
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
                onPressed: () async {
                  await viewModel.updateUser();
                },
                text: "Next",
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: Colors.grey.withOpacity(.2),
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 offset: Offset(0, 10),
//                 blurRadius: 10,
//               ),
//             ],
//           ),