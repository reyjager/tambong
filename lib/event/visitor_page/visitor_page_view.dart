import 'package:tambong/event/visitor_page/visitor_page_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VisitorPageView extends StatelessWidget {
  final String eventId;
  const VisitorPageView({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VisitorPageViewModel>.reactive(
      viewModelBuilder: () => VisitorPageViewModel(eventId: eventId),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance'),
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.allVisitors.isEmpty
                  ? const Center(child: Text('No attendees found'))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ThemeService
                                    .currentColorScheme.primaryColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 16.0),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Church',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Position',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(child: SizedBox()),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                var visitor = model.allVisitors[index];
                                Color rowColor = index % 2 == 0
                                    ? Color.fromRGBO(63, 48, 109, 0.106)
                                    : Color.fromRGBO(134, 132, 246, 0.106);
                                if (visitor["position"] == "Visitor") {
                                  rowColor = Color.fromARGB(255, 243, 212, 118);
                                }

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: rowColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(visitor['name']),
                                          ),
                                          Expanded(
                                            child: Text(
                                              visitor['church'],
                                              textAlign: TextAlign.right,
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              visitor['position'],
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: model.allVisitors.length,
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
