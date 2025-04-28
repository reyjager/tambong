import 'package:tambong/event/create_event/create_event_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/section_header_widgets.dart';
import 'package:tambong/widgets/textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CreateEventViewmodel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: ThemeService.currentColorScheme.primaryColor,
              title: const Text("Create an Event"),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionHeader(
                      title: "Event Information",
                      myColor: ThemeService.currentColorScheme.primaryColor,
                    ),
                    CustomTextField(
                        controller: model.eventNamectrl,
                        labelText: "Event Name:"),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: model.eventDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          model.setEventDate(pickedDate);
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller: model.eventDateCtrl,
                          labelText: "Event Date:",
                          hintText: model.eventDate != null
                              ? model.eventDate!
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]
                              : 'Select Date',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: model.eventTime ?? TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          model.setEventTime(context, pickedTime);
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller: model.eventTimeCtrl,
                          labelText: "Event Time:",
                          hintText: model.eventTime != null
                              ? model.eventTime!.format(context)
                              : 'Select Time',
                        ),
                      ),
                    ),
                    CustomTextField(
                        controller: model.eventSpeakerCtrl,
                        labelText: "Speaker:"),
                    SectionHeader(
                        title: "Organizer Information",
                        myColor: ThemeService.currentColorScheme.primaryColor),
                    CustomTextField(
                        controller: model.eventVenueCtrl, labelText: "Venue:"),
                    CustomTextField(
                        controller: model.orgNameCtrl, labelText: "Organizer:"),
                    CustomTextField(
                        controller: model.orgEmailCtrl, labelText: "Email:"),
                    CustomTextField(
                        controller: model.orgContactCtrl,
                        labelText: "Contact:"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: CustomElevatedButton(
                          backgroundColor:
                              ThemeService.currentColorScheme.primaryColor,
                          text: "Create",
                          onPressed: model.gotoCreateEvent),
                    ),
                  ],
                ),
              ),
            )),
          );
        });
  }
}
