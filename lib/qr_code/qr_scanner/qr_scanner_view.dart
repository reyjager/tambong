import 'package:tambong/qr_code/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QRScannerViewModel>.reactive(
      viewModelBuilder: () => QRScannerViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            title: const Text('QR Code Scanner'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              QRView(
                key: GlobalKey(debugLabel: 'QR'),
                onQRViewCreated: (controller) async {
                  // Add a delay to allow the camera to focus
                  await Future.delayed(const Duration(seconds: 5));
                  controller.scannedDataStream.listen((scanData) {
                    model.handleScan(scanData);
                    print("enjoy scanning========");
                    const Duration(seconds: 3);
                  });
                },
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              if (model.successMessage != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      model.successMessage!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 4, 180, 86),
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              else if (model.message != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      model.message!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ),

              if (model.isBusy)
                const Center(
                  child: CircularProgressIndicator(),
                ), // Show a loading indicator if busy
            ],
          ),
        );
      },
    );
  }
}
