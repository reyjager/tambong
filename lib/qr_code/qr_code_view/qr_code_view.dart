import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/arc_drawing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';
import 'qr_code_viewmodel.dart';

class QrCodeView extends StatelessWidget {
  final String name;
  final String documentId;
  final String eventId;
  final String eventName;

  const QrCodeView(
      {Key? key,
      required this.name,
      required this.documentId,
      required this.eventId,
      required this.eventName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrCodeViewModel>.reactive(
      viewModelBuilder: () => QrCodeViewModel(
          name: name,
          documentId: documentId,
          eventId: eventId,
          eventName: eventName),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('QR Code'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: ThemeService.currentColorScheme.primaryColor,
        ),
        body: Stack(children: [
          ClipPath(
            clipper: HeadArcDrawing(),
            child: Container(
              color: Colors.amber,
              height: 100,
              width: double.infinity,
            ),
          ),
          ClipPath(
            clipper: HeadArcDrawing2(),
            child: Container(
              color: ThemeService.currentColorScheme.primaryColor,
              height: 100,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      model.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
              left: 0,
              right: 0,
              bottom: 90,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Please present this QR code when you arrive at the venue.",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              )),
          Center(
            child: QrImageView(
              data: model.qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomArcDrawing(),
              child: Container(
                color: Colors.amber,
                height: 100,
                width: double.infinity,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomArcDrawing2(),
              child: Container(
                color: ThemeService.currentColorScheme.primaryColor,
                height: 100,
                width: double.infinity,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
