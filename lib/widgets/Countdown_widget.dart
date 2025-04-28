import 'package:tambong/home/countdown_timer_service.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CountdownWidget extends StatelessWidget {
  final String eventDate;
  final String eventTime;

  const CountdownWidget(
      {super.key, required this.eventDate, required this.eventTime});
  @override
  Widget build(BuildContext context) {
    DateTime eventDateTime =
        CountdownTimerService().parseDateTime(eventDate, eventTime);
    DateTime now = DateTime.now();
    bool isCountDownFinished = now.isAfter(eventDateTime);

    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
          color: ThemeService.currentColorScheme.primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Visibility(
        visible: !isCountDownFinished,
        replacement: const Center(
          child: Text(
            "WELCOME",
            style: TextStyle(fontSize: 20, color: Colors.amber),
          ),
        ),
        child: Center(
          child: TimerCountdown(
              colonsTextStyle: const TextStyle(color: Colors.white),
              descriptionTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 10),
              format: CountDownTimerFormat.daysHoursMinutesSeconds,
              endTime: eventDateTime,
              // endTime: DateTime(2024, 8, 17),
              timeTextStyle: TextStyle(
                color: Colors.amber,
                fontSize: 20,
                backgroundColor: ThemeService.currentColorScheme.primaryColor,
              )),
        ),
      ),
    );
  }
}
