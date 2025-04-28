import 'package:tambong/home/countdown_timer_service.dart';
import 'package:tambong/model/event_model.dart';
import 'package:tambong/event/event_service/event_service.dart';
import 'package:tambong/event/menu_event/menu_event_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel() {
    refreshData();
  }

  bool eventIsDone = false;

  List<Event> _historyEvents = [];
  List<Event> get historyEvents => _historyEvents;

  List<Event> _upComingEvents = [];
  List<Event> get upComingEvents => _upComingEvents;

  List<String> results = [];
  late int days, hours, minutes;
  int _currentIndex = 0;

  List<int> remainDateAndTime = [];

  int get currentIndex => _currentIndex;
  String no_History = "No History Event Found";
  String no_Upcoming = "No Upcoming Event Found";

  refreshData() async {
    setBusy(true);
    _historyEvents = await EventService().getHistoryEvents();
    _upComingEvents = await EventService().getUpComingEvents();
    // _allEvents = await EventService().getAllEvents();

    updateCompletedEvents();
    notifyListeners();
    setBusy(false);
  }

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> updateCompletedEvents() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (var event in _upComingEvents) {
      DateTime eventDateTime = CountdownTimerService()
          .parseDateTime(event.eventDate, event.eventTime);
      print(
          "+++++++ date now $now ====== ++++++++ event date time $eventDateTime");
      DateTime eventDate = DateTime.parse(event.eventDate);
      if (eventDate.isBefore(today)) {
        print("update event is done to true. ");
        await EventService().markEventAsDone(event.docId!);
      }
    }
  }

  gotoRegisterThisEvent(Event eventId) {
    print("event details are ${eventId}");
    Get.to(() => MenuEventView(event: eventId));
  }

  String convertDateFormat(String date) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateFormat outputFormat = DateFormat('MMMM dd, yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    String formattedDate = outputFormat.format(parsedDate);
    return formattedDate;
  }

  String preferedDateAndTimeFormat(String eventDate) {
    DateTime parsedDate = DateTime.parse(eventDate);
    String formattedDate = DateFormat('MMMM d, yyyy').format(parsedDate);
    return formattedDate;
  }
}
