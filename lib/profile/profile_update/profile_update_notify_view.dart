import 'package:tambong/profile/profile_update/profile_update_notify_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileUpdateViewResponse extends StatelessWidget {
  const ProfileUpdateViewResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ProfileUpdateNotifyViewModel(),
        builder: (context, model, child) {
          return const Scaffold(
            body: Center(
              child: const Column(
                children: [
                  Icon(Icons.check_box, color: Colors.green, size: 45),
                  Text(
                    "Successfully Update",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
