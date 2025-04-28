import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tambong/model/event_model.dart';
import 'package:tambong/home/home_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/Countdown_widget.dart';

class EventCarousel extends StatelessWidget {
  final List<Event> events;
  final bool autoPlay;

  EventCarousel({
    super.key,
    required this.events,
    required this.autoPlay,
  });

  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Use the correct controller type

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        _buildIndicator(context),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280.0,
        autoPlay: autoPlay,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          HomeViewModel().setIndex(index);
        },
      ),
      carouselController: _carouselController,
      items: events.map((event) => _buildCarouselItem(event)).toList(),
    );
  }

  Widget _buildCarouselItem(Event event) {
    return GestureDetector(
      onTap: event.eventIsDone!
          ? null
          : () {
              HomeViewModel().gotoRegisterThisEvent(event);
            },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEventContent(event),
              _buildEventDetails(event),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventContent(Event event) {
    if (event.eventIsDone!) {
      return const SuccessfulEventWidget();
    } else {
      return CountdownWidget(
        eventDate: event.eventDate,
        eventTime: event.eventTime,
      );
    }
  }

  Widget _buildEventDetails(Event event) {
    return Column(
      children: [
        Text(
          event.eventName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (event.eventIsDone != true)
          Text(
            HomeViewModel().convertDateFormat(event.eventDate),
            style: const TextStyle(fontSize: 10),
          ),
        if (event.eventIsDone != true)
          Text(
            event.eventTime,
            style: const TextStyle(fontSize: 10),
          ),
        if (event.eventIsDone != true)
          Text(
            "Speaker: ${event.eventSpeaker}",
            style: const TextStyle(fontSize: 10),
          ),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: events.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(
              entry.key), // Ensure this method is correct in version 5.0.0
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.amber)
                  .withOpacity(
                      HomeViewModel().currentIndex == entry.key ? 0.9 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SuccessfulEventWidget extends StatelessWidget {
  const SuccessfulEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        color: ThemeService.currentColorScheme.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Successful Event",
            style: TextStyle(color: Colors.white),
          ),
          Icon(Icons.star, size: 40, color: Colors.amber),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "-------",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_circle_up,
                color: Colors.white,
              ),
              Text(
                "-------",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
