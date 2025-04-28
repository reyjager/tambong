import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'html_viewmodel.dart';

class HtmlView extends StatelessWidget {
  final String eventName;
  HtmlView({required this.eventName});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HtmlViewModel>.reactive(
      viewModelBuilder: () => HtmlViewModel(eventName: eventName),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: ThemeService.currentColorScheme.primaryColor,
          title: Text('Song'),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (viewModel.urlMessage != null &&
                  viewModel.urlMessage!.isNotEmpty) ...[
                SizedBox(height: 20),
                Text(
                  viewModel.urlMessage ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
              if (viewModel.downloadUrl != null) ...[
                const Text(
                  'Scan to View Programme',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                QrImageView(
                  data: viewModel.downloadUrl!,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
              SizedBox(height: 20),
              if (viewModel.isAdmin == true)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () => viewModel.uploadHtmlFile(),
                    textColor: Colors.white,
                    backgroundColor:
                        ThemeService.currentColorScheme.primaryColor,
                    text: "Upload Programme",
                  ),
                ),
              if (viewModel.isAdmin == true)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      String docId =
                          'YOUR_DOCUMENT_ID'; // Replace with the actual document ID
                      await viewModel.fetchHtmlFile();
                    },
                    textColor: Colors.white,
                    backgroundColor:
                        ThemeService.currentColorScheme.primaryColor,
                    text: "Fetch Programme File",
                  ),
                ),
              if (viewModel.isAdmin == true)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      String docId =
                          '7KoJ98wzLkPI3WYKZ00G'; // Replace with the actual document ID
                      await viewModel.updateHtmlFile(docId);
                    },
                    textColor: Colors.white,
                    backgroundColor:
                        ThemeService.currentColorScheme.primaryColor,
                    text: "Update Programme File",
                  ),
                ),
              if (viewModel.isAdmin == true)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomElevatedButton(
                    onPressed: () async {
                      String docId =
                          '7KoJ98wzLkPI3WYKZ00G'; // Replace with the actual document ID
                      await viewModel.deleteHtmlFile(docId);
                    },
                    textColor: Colors.white,
                    backgroundColor:
                        ThemeService.currentColorScheme.primaryColor,
                    text: "Delete Programme File",
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(
                  onPressed: () async {
                    if (viewModel.downloadUrl != null) {
                      await viewModel.launchInBrowser(viewModel.downloadUrl!);
                    }
                  },
                  textColor: Colors.white,
                  backgroundColor: ThemeService.currentColorScheme.primaryColor,
                  text: "Open ${eventName} Programme",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
