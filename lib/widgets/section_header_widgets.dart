import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Color? myColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.myColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: myColor ?? Colors.white),
            ),
          ),
          Expanded(
              child: Divider(
            color: myColor ?? Colors.white,
          )),
        ],
      ),
    );
  }
}
