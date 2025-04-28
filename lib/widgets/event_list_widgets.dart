// import 'package:tambong/event/list_of_events/event_list_viewmodel.dart';
// import 'package:tambong/model/event_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stacked/stacked.dart';

// class EventList extends StatelessWidget {
//   final Event event;

//   const EventList({
//     super.key,
//     required this.event,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//         viewModelBuilder: () => EventListViewModel(),
//         builder: (context, model, child) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: Colors.grey.withOpacity(.2),
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     offset: const Offset(0, 10),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             event.eventName,
//                             style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             event.eventDate,
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.black45),
//                           ),
//                           Text(
//                             event.eventTime,
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.black45),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text("Registered:"),
//                               Text("0"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text("Present:"),
//                               Text("0"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text("Visitor: "),
//                               Text("0"),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
