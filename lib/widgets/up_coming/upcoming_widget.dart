import 'package:flutter/material.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Anniversary",
          style: TextStyle(fontSize: 12),
        ),
        Text(
          "24th July 2024",
          style: TextStyle(fontSize: 12),
        ),
        Text(
          "@ 10:00 AM - 4:00 PM",
          style: TextStyle(fontSize: 12),
        ),
        Text(
          "Ptr Ceasar De Torres",
          style: TextStyle(fontSize: 12),
        ),
        // Divider(),
      ],
    );
  }
}
