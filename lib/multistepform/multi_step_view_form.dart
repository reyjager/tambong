import 'package:tambong/multistepform/multistep_form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'name_step_view.dart';
import 'position_step_view.dart';
import 'church_step_view.dart';

class MultiStepFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultiStepFormViewModel>.reactive(
      viewModelBuilder: () => MultiStepFormViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Multi-Step Form')),
          body: IndexedStack(
            index: viewModel.currentStep,
            children: [
              NameStepView(),
              ChurchStepView(),
              PositionStepView(),
            ],
          ),
        );
      },
    );
  }
}
