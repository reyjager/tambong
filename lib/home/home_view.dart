import 'package:firebase_auth/firebase_auth.dart';
import 'package:tambong/home/empty_carousel.dart';
import 'package:flutter/material.dart';
import 'package:tambong/drawer/drawer_view.dart';
import 'package:tambong/home/event_carousel.dart';
import 'package:tambong/home/home_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tambong/widgets/section_header_widgets.dart';

class HomeView extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ThemeService.currentColorScheme.primaryColor,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            leading: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  "assets/images/system/logo.png",
                  height: 30,
                  width: 30,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          drawer: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Drawer(child: DrawerView(firebaseAuth: _firebaseAuth)),
          ),
          body: SafeArea(
            child: GestureDetector(
              onVerticalDragDown: (details) async {
                await model.refreshData();
                print("++++++++=+ invoked refresh data $details");
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SectionHeader(title: "Upcoming Event"),
                      model.upComingEvents.isEmpty
                          ? model.isBusy
                              ? const Center(
                                  child:
                                      CircularProgressIndicator()) // Show loading indicator
                              : EmptyCarousel(
                                  message: model
                                      .no_Upcoming) // Show empty carousel message
                          : EventCarousel(
                              events: model.upComingEvents,
                              autoPlay: false,
                            ),
                      const SectionHeader(title: "History Event"),
                      model.historyEvents.isEmpty
                          ? EmptyCarousel(message: model.no_History)
                          : EventCarousel(
                              events: model.historyEvents,
                              autoPlay: false,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildSectionHeader(
  //     BuildContext context, String title, String message) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15),
  //           child: Text(
  //             title,
  //             style: const TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white),
  //           ),
  //         ),
  //         const Expanded(child: Divider()),
  //       ],
  //     ),
  //   );
  // }
}
