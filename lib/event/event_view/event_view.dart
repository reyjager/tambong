import 'package:tambong/event/event_view/event_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventViewModel>.reactive(
      viewModelBuilder: () => EventViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            title: const Text("Events"),
          ),
          body: Column(
            children: [
              Expanded(
                child: model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : model.events == null || model.events!.isEmpty
                        ? const Center(child: Text('No events found'))
                        : Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: ListView.builder(
                              itemCount: model.events!.length,
                              itemBuilder: (context, index) {
                                final event = model.events![index];
                                return EventWidget(
                                  event: event,
                                  onTap: () {
                                    print(
                                        "[debug]this is event in event view ${event.docId}");
                                    print(
                                        "[debug]this is event in event views ${event}");
                                    model.gotoEvenTInfoView(event);
                                  },
                                );
                              },
                            ),
                          ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: CustomElevatedButton(
                  text: "Create Event",
                  backgroundColor: ThemeService.currentColorScheme.primaryColor,
                  onPressed: () {
                    model.gotoCreateEvent();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
