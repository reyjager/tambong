import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/profile/complete_profile/complete_profile_viewmodel.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CompleteProfileView extends StatelessWidget {
  final bool isEdit;

  const CompleteProfileView({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompleteProfileViewModel>.reactive(
      viewModelBuilder: () => CompleteProfileViewModel(isEdit: isEdit),
      onModelReady: (model) {
        if (isEdit) {
          model.fetchUserById("userId"); // Adjust userId as needed
        }
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            title: const Text(
              "Profile View",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (isEdit) ...[
                    CustomTextField(
                        controller: model.nameController,
                        labelText: 'First Name'),
                    CustomTextField(
                        controller: model.ageController, labelText: 'Age'),
                    CustomTextField(
                        controller: model.churchController,
                        labelText: 'Church'),
                    // CustomDropdownFieldPosition(
                    //   value: model.selectedPosition,
                    //   labelText: 'Position',
                    //   items: model.positionOptions,
                    //   onChanged: model.updateSelectedPosition,
                    // ),
                    DropdownButtonFormField<Position>(
                      decoration: const InputDecoration(
                        labelText: 'Select Position',
                        border: OutlineInputBorder(),
                      ),
                      value: model.selectedPosition,
                      items: Position.values.map((Position position) {
                        return DropdownMenuItem<Position>(
                          value: position,
                          child: Text(position.toString()),
                        );
                      }).toList(),
                      onChanged: model.updateSelectedPosition,
                    ),
                    CustomTextField(
                        controller: model.addressController,
                        labelText: 'Address'),
                    CustomTextField(
                        controller: model.mobileNoController,
                        labelText: 'Mobile No'),
                  ] else ...[
                    Row(children: [
                      const Text("Name:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("${model.user!.completeName}"),
                    ]),
                    Row(children: [
                      const Text("Age:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // Text(model.user.age),
                    ]),
                    Row(children: [
                      const Text("Church:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // Text(model.user!.church)
                    ]),
                    Row(children: [
                      const Text("Position:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // Text(model.user!.position)
                    ]),
                    Row(children: [
                      const Text("Address:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      // Text(model.user!.address)
                    ]),
                    Row(children: [
                      const Text("Mobile No:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(model.user!.mobileNo)
                    ]),
                  ],
                  const SizedBox(height: 15),
                  if (isEdit) ...[
                    CustomElevatedButton(
                      text: 'Complete Registration',
                      onPressed: () => model.completeRegistration(
                          "userId"), // Adjust userId as needed
                      backgroundColor:
                          ThemeService.currentColorScheme.primaryColor,
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                              text: "Cancel",
                              backgroundColor:
                                  ThemeService.currentColorScheme.primaryColor,
                              onPressed: () => model.goToHomePage(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                              text: "Edit Profile",
                              backgroundColor:
                                  ThemeService.currentColorScheme.primaryColor,
                              onPressed: () => model.gotoEditProfile(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
