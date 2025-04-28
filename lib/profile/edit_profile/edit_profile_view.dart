import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/model/app_user_model.dart';
import 'package:tambong/profile/edit_profile/edit_profile_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatelessWidget {
  final AppUser user;
  const EditProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(user: user),
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                foregroundColor: Colors.white,
                backgroundColor: ThemeService.currentColorScheme.primaryColor,
                title: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
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
                        labelText: 'Mobile No',
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomElevatedButton(
                                text: "Back Page",
                                backgroundColor: ThemeService
                                    .currentColorScheme.primaryColor,
                                onPressed: () => model.goBackPage(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomElevatedButton(
                                text: "Update Now",
                                backgroundColor: ThemeService
                                    .currentColorScheme.primaryColor,
                                onPressed: () => model.updateUserInformation(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )));
        });
  }
}
