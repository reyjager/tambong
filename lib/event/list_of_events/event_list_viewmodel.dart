import 'package:tambong/event/event_service/event_service.dart';
import 'package:tambong/model/event_model.dart';
import 'package:stacked/stacked.dart';

class EventListViewModel extends BaseViewModel {
  final EventService eventService = EventService();
  List<Event> events = [];

  EventListViewModel() {
    fetchAllEvents();
  }

  fetchAllEvents() async {
    setBusy(true);

    events = await eventService.getAllEvents();
    print("get all events: $events");
    notifyListeners();

    print("[DEBUG] The list of events is: ${events.length}");
    setBusy(false);
    notifyListeners();
  }
}
