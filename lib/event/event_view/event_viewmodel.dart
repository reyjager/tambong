import 'package:tambong/event/create_event/create_event_view.dart';
import 'package:tambong/event/event_info/event_info_view.dart';
import 'package:tambong/event/event_service/event_service.dart';
import 'package:tambong/model/event_model.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EventViewModel extends BaseViewModel {
  final EventService eventService = EventService();

  EventViewModel() {
    fetchAllEvents();
  }

  @override
  void dispose() {
    super.dispose();
    fetchAllEvents(); // Refetch data when the view model is disposed
  }

  List<Event>? _events;
  List<Event>? get events => _events;

  Future<void> fetchAllEvents() async {
    setBusy(true);
    try {
      _events = await eventService.getAllEvents();
      notifyListeners();
    } catch (e) {
      throw Exception("Fetching Error: $e");
    } finally {
      setBusy(false);
    }
  }

  Future<void> addEvent(Event event) async {
    setBusy(true);
    try {
      await eventService.addEvent(event);
      await fetchAllEvents(); // Refresh the list
    } catch (e) {
      // Handle error (show message, etc.)
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateEvent(String id, Event event) async {
    setBusy(true);
    try {
      await eventService.updateEvent(id, event);
      await fetchAllEvents(); // Refresh the list
    } catch (e) {
      // Handle error (show message, etc.)
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteEvent(String id) async {
    setBusy(true);
    try {
      await eventService.deleteEvent(id);
      await fetchAllEvents(); // Refresh the list
    } catch (e) {
    } finally {
      setBusy(false);
    }
  }

  gotoCreateEvent() {
    Get.to(() => const CreateEventView());
  }

  gotoEvenTInfoView(event) {
    Get.to(() => EventInfoView(event: event));
  }
}
