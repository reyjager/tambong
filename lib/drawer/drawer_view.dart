import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'drawer_viewmodel.dart';

class DrawerView extends StatelessWidget {
  final FirebaseAuth firebaseAuth;

  const DrawerView({super.key, required this.firebaseAuth});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DrawerViewModel>.reactive(
      viewModelBuilder: () => DrawerViewModel(),
      builder: (context, model, child) => Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 200,
                  color: ThemeService.currentColorScheme.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/tambong_logo.png',
                        height: 110,
                        width: 110,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        model.currentUserEmail!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                        color: ThemeService.currentColorScheme.primaryColor),
                  ),
                  onTap: model.navigateToProfile,
                  iconColor: ThemeService.currentColorScheme.primaryColor,
                  splashColor: ThemeService.currentColorScheme.primaryColor,
                ),
                if (model.isAdmin == true)
                  ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(
                      'Manage Event',
                      style: TextStyle(
                          color: ThemeService.currentColorScheme.primaryColor),
                    ),
                    onTap: model.navigateToEvent,
                    iconColor: ThemeService.currentColorScheme.primaryColor,
                    splashColor: ThemeService.currentColorScheme.primaryColor,
                  ),

                // ListTile(
                //   leading: const Icon(Icons.qr_code),
                //   title: Text(
                //     'QR Codes',
                //     style: TextStyle(
                //         color: ThemeService.currentColorScheme.primaryColor),
                //   ),
                //   onTap: model.navigateToQRCode,
                //   iconColor: ThemeService.currentColorScheme.primaryColor,
                //   splashColor: ThemeService.currentColorScheme.primaryColor,
                // ),

                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: ThemeService.currentColorScheme.primaryColor),
                  ),
                  onTap: model.navigateToSettings,
                  iconColor: ThemeService.currentColorScheme.primaryColor,
                  splashColor: ThemeService.currentColorScheme.primaryColor,
                ),
                // ListTile(
                //   leading: const Icon(Icons.policy),
                //   title: Text(
                //     'Policy',
                //     style: TextStyle(
                //         color: ThemeService.currentColorScheme.primaryColor),
                //   ),
                //   onTap: model.navigateToPolicy,
                //   iconColor: ThemeService.currentColorScheme.primaryColor,
                //   splashColor: ThemeService.currentColorScheme.primaryColor,
                // ),
                ListTile(
                  leading: const Icon(Icons.contacts),
                  title: Text(
                    'Contacts',
                    style: TextStyle(
                        color: ThemeService.currentColorScheme.primaryColor),
                  ),
                  onTap: model.navigateToContacts,
                  iconColor: ThemeService.currentColorScheme.primaryColor,
                  splashColor:
                      ThemeService.currentColorScheme.primaryColor[500],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            iconColor: Colors.white,
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
            onTap: model.signOut,
            tileColor: ThemeService.currentColorScheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
