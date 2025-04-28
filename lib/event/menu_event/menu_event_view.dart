import 'package:tambong/enum/List_chuch_position.dart';
import 'package:tambong/model/event_model.dart';
import 'package:tambong/event/menu_event/menu_event_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:tambong/widgets/textfields_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MenuEventView extends StatelessWidget {
  final Event event;

  const MenuEventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuEventViewModel>.reactive(
      viewModelBuilder: () => MenuEventViewModel(event: event),
      builder: (context, model, child) {
        return DefaultTabController(
          length: model.isAdmin! ? 5 : 3,
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: Text(
                event.eventName,
                style: const TextStyle(color: Colors.white),
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
              bottom: TabBar(
                dividerColor: Colors.white,
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const ScrollPhysics(),
                tabs: [
                  const Tab(text: 'Register', icon: Icon(Icons.person_add)),
                  if (model.isAdmin == true) ...[
                    const Tab(
                        text: 'Arrived',
                        icon: Icon(Icons.assignment_turned_in)),
                    const Tab(text: 'Scan', icon: Icon(Icons.document_scanner)),
                  ],
                  const Tab(text: 'QrCode', icon: Icon(Icons.qr_code)),
                  const Tab(text: 'Programme', icon: Icon(Icons.event_note)),
                ],
                labelStyle: const TextStyle(fontSize: 8),
              ),
              backgroundColor: ThemeService.currentColorScheme.primaryColor,
            ),
            body: TabBarView(
              children: [
                // Register Tab
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: model.nameController,
                        labelText: "Complete Name",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: DropdownButtonFormField<Church>(
                          decoration: const InputDecoration(
                            labelText: 'Select Church',
                            border: OutlineInputBorder(),
                          ),
                          value: model.selectedChurch,
                          items: Church.values.map((Church church) {
                            return DropdownMenuItem<Church>(
                              value: church,
                              child: Text(church.toString()),
                            );
                          }).toList(),
                          onChanged: model.updateSelectedChurch,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: DropdownButtonFormField<Position>(
                          decoration: const InputDecoration(
                            labelText: 'Select Position',
                            border: OutlineInputBorder(),
                          ),
                          value: model.selectedPosition,
                          items: Position.values.map((Position position) {
                            return DropdownMenuItem<Position>(
                              value: position,
                              child: Text(position.toString()),
                            );
                          }).toList(),
                          onChanged: model.updateSelectedPosition,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (model.isAdmin == true)
                            CustomElevatedButton(
                              onPressed: () {
                                model.gotoAttendeesView(event);
                              },
                              backgroundColor:
                                  ThemeService.currentColorScheme.primaryColor,
                              text: "View Attendance",
                            ),
                          CustomElevatedButton(
                            onPressed: () async {
                              model.registerForEvent();
                            },
                            backgroundColor:
                                ThemeService.currentColorScheme.primaryColor,
                            text: "Register Event",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (model.isAdmin == true)
                  // Arrived Tab
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: model.nameController,
                          labelText: "Complete Name",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: DropdownButtonFormField<Church>(
                            decoration: const InputDecoration(
                              labelText: 'Select Church',
                              border: OutlineInputBorder(),
                            ),
                            value: model.selectedChurch,
                            items: Church.values.map((Church church) {
                              return DropdownMenuItem<Church>(
                                value: church,
                                child: Text(church.toString()),
                              );
                            }).toList(),
                            onChanged: model.updateSelectedChurch,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: DropdownButtonFormField<Position>(
                            decoration: const InputDecoration(
                              labelText: 'Select Position',
                              border: OutlineInputBorder(),
                            ),
                            value: model.selectedPosition,
                            items: Position.values.map((Position position) {
                              return DropdownMenuItem<Position>(
                                value: position,
                                child: Text(position.toString()),
                              );
                            }).toList(),
                            onChanged: model.updateSelectedPosition,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Text(
                            "Has Arrived",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SwitchListTile(
                          value: model.hasArrived,
                          onChanged: model.updateHasArrived,
                          title: Text(model.hasArrived ? "Yes" : "No"),
                          activeColor: Colors.green,
                        ),
                        if (model.notificationMessage.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 30),
                            child: Container(
                              color: ThemeService
                                  .currentColorScheme.dangerColor[800],
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Icon(
                                      Icons.error,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      model.notificationMessage,
                                      maxLines: 3,
                                      softWrap: true,
                                      overflow: TextOverflow
                                          .visible, // Ensure overflow is handled
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 171, 95,
                                              95)), // Ensure text is visible
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomElevatedButton(
                            onPressed: () async {
                              model.gotoArrived();
                            },
                            backgroundColor:
                                ThemeService.currentColorScheme.primaryColor,
                            text: "Arrive",
                          ),
                        ),
                      ],
                    ),
                  ),
                // Scan Tab
                if (model.isAdmin == true)
                  Center(
                      child: ElevatedButton(
                    onPressed: () => model.gototQRCodeScanner(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          ThemeService.currentColorScheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12.0), // Customize the border radius here
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Adjusts column size based on its content
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 50,
                          ), // Choose the appropriate icon
                          SizedBox(
                              height:
                                  10), // Add some spacing between the icon and text
                          Text("Click to Scan your QR Code"),
                        ],
                      ),
                    ),
                  )),
                //Qrcode Tab
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ThemeService.currentColorScheme.primaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 16.0),
                          child: const Column(
                            children: [
                              Center(
                                child: Text(
                                  "Select Name to generate QR Code",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Church',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Position',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox()),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var attendee = model.attendeesUnderUserId[index];
                            Color rowColor = index % 2 == 0
                                ? const Color.fromRGBO(63, 48, 109, 0.106)
                                : const Color.fromRGBO(134, 132, 246, 0.106);
                            if (attendee["position"] == "Visitor") {
                              rowColor =
                                  const Color.fromARGB(255, 243, 212, 118);
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: InkWell(
                                onTap: () {
                                  model.gotoQRCodeView(
                                      attendee['name'],
                                      attendee['docId'],
                                      event.docId,
                                      event.eventName);
                                  print(
                                      "Tapped on ${attendee['name']} === ${attendee['docId']} ==== ${event.docId}");
                                },
                                borderRadius: BorderRadius.circular(15),
                                splashColor: Colors.amber,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: rowColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(attendee['name']),
                                        ),
                                        Expanded(
                                          child: Text(
                                            attendee['church'],
                                            textAlign: TextAlign.right,
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            attendee['position'],
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: model.attendeesUnderUserId.length,
                        ),
                      ),
                    ],
                  ),
                ),
                //Programme Tab
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: CustomElevatedButton(
                      onPressed: model.gotoHtmlView,
                      textColor: Colors.white,
                      backgroundColor:
                          ThemeService.currentColorScheme.primaryColor,
                      text: "Song",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
