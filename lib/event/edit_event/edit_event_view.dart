import 'package:tambong/event/edit_event/edit_event_viewmodel.dart';
import 'package:tambong/model/event_model.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditEventView extends StatelessWidget {
  final Event event;

  EditEventView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EditEventViewModel(event),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            title: const Text("Edit Event"),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5.0, bottom: 5),
                          child: Text(
                            "Event Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width / 1.95,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      controller: model.eventNamectrl,
                      labelText: "Event Name:",
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: model.eventDate ?? DateTime.now(),
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
                      labelText: "Speaker:",
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomElevatedButton(
                        backgroundColor:
                            ThemeService.currentColorScheme.primaryColor,
                        text: "Update",
                        onPressed: model.gotoUpdateEvent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
