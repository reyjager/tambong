import 'package:tambong/profile/profile_views/profile_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile View'),
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileInfoRow(Icons.person, "Name",
                              "${model.user?.completeName ?? ''} "),
                          _buildProfileInfoRow(Icons.cake, "Age",
                              model.user?.age.toString() ?? ''),
                          _buildProfileInfoRow(
                              Icons.church, "Church", model.user?.church ?? ''),
                          _buildProfileInfoRow(Icons.work, "Position",
                              model.user?.position ?? ''),
                          _buildProfileInfoRow(
                              Icons.home, "Address", model.user?.address ?? ''),
                          _buildProfileInfoRow(Icons.phone, "Mobile no.",
                              model.user?.mobileNo ?? ''),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              ThemeService.currentColorScheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Back Home'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          model.gotoEditProfile();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              ThemeService.currentColorScheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[900]),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
