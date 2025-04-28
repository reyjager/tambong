// import 'package:tambong/event/list_of_events/event_list_viewmodel.dart';
// import 'package:tambong/themes/theme_service.dart';
// import 'package:tambong/widgets/event_list_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class EventListView extends StatelessWidget {
//   const EventListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<EventListViewModel>.reactive(
//       viewModelBuilder: () => EventListViewModel(),
//       builder: (context, model, child) {
//         return Scaffold(
//           appBar: AppBar(
//             foregroundColor: Colors.white,
//             backgroundColor: ThemeService.currentColorScheme.primaryColor,
//             title: const Text("List of Events"),
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: model.isBusy
//                     ? const Center(child: CircularProgressIndicator())
//                     : model.events.isEmpty
//                         ? const Center(child: Text('No events found'))
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 25),
//                             child: ListView.builder(
//                               itemCount: model.events.length,
//                               itemBuilder: (context, index) {
//                                 final event = model.events[index];
//                                 return EventList(event: event);
//                               },
//                             ),
//                           ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
