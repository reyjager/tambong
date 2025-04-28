import 'package:tambong/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/event/event_info/event_info_viewmodel.dart';

class EventInfoView extends StatelessWidget {
  final Event event;
  const EventInfoView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventInfoViewmodel>.reactive(
      viewModelBuilder: () => EventInfoViewmodel(event: event),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            title: const Text("Event Information"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                )),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return _eventInformation(
                              context, "Event Name", event.eventName);
                        case 1:
                          return _eventInformation(
                              context, "Event Date", event.eventDate);
                        case 2:
                          return _eventInformation(
                              context, "Event Time", event.eventTime);
                        case 3:
                          return _eventInformation(
                              context, "Event Speaker", event.eventSpeaker);
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                    childCount: 4,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 2 / 1,
                  ),
                ),
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                )),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return _eventData(context, "Total Present",
                              model.attendees.length.toString(), () {});
                        case 1:
                          return _eventData(context, "NLFBC",
                              "${model.eventdata['nlfbcTotal']}", () {});
                        case 2:
                          return _eventData(context, "JUFBC",
                              "${model.eventdata['jufbcTotal']}", () {});
                        case 3:
                          return _eventData(context, "NLFBC Thuwal",
                              "${model.eventdata['nlfbcTTotal']}", () {});
                        case 4:
                          return _eventData(context, "Visitor",
                              "${model.eventdata['visitorTotal']}", () {
                            model.gotoVistorPage(event.docId);
                          });
                        case 5:
                          return _eventData(context, "Others",
                              "${model.eventdata['otherChurchCount']}", () {});
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                    childCount: 6,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: .5,
                    mainAxisSpacing: 1,
                    childAspectRatio: 2 / 1,
                  ),
                ),
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(),
                )),
                SliverPadding(
                  padding: const EdgeInsets.all(15.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomElevatedButton(
                              backgroundColor:
                                  ThemeService.currentColorScheme.primaryColor,
                              text: "Edit",
                              onPressed: () =>
                                  model.editEventInformation(event),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomElevatedButton(
                              backgroundColor:
                                  ThemeService.currentColorScheme.primaryColor,
                              text: "Delete",
                              onPressed: () => model.deleteEvent(event.docId),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _eventInformation(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Card(
        color: ThemeService.currentColorScheme.primaryColor,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.amber, fontSize: 12),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  content,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _eventData(
      BuildContext context, String title, String content, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Card(
          color: ThemeService.currentColorScheme.primaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    content,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: const TextStyle(color: Colors.amber, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
