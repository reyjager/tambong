import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stacked/stacked.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tambong/authentication/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlViewModel extends BaseViewModel {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String eventName;

  HtmlViewModel({required this.eventName}) {
    checkUserIsAdmin();
  }

  String? urlMessage = "";

  String? _downloadUrl;
  String? get downloadUrl => _downloadUrl;

  bool? _isAdmin;
  bool? get isAdmin => _isAdmin;

  Future checkUserIsAdmin() async {
    _isAdmin = await AuthenticationService.getCurrentUserIsAdmin();
    notifyListeners();
  }

  Future<void> uploadHtmlFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['html'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      // Upload the file to Firebase Storage
      TaskSnapshot snapshot = await _storage
          .ref('html_files/${file.path.split('/').last}')
          .putFile(file);

      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save the download URL to Firestore using eventName as the document ID
      await _firestore.collection('html_files').doc(eventName).set({
        'file_name': file.path.split('/').last,
        'url': downloadUrl,
      });

      _downloadUrl = downloadUrl;
      notifyListeners();
    }
  }

  Future<void> fetchHtmlFile() async {
    DocumentSnapshot snapshot =
        await _firestore.collection('html_files').doc(eventName).get();
    urlMessage = "";
    notifyListeners();
    if (snapshot.exists) {
      _downloadUrl = snapshot['url'];
      notifyListeners();
    } else {
      urlMessage = "No Programme Found";
      notifyListeners();
    }
  }

  Future<void> updateHtmlFile(String docId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['html'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      // Upload the new file to Firebase Storage
      TaskSnapshot snapshot =
          await _storage.ref('song/${file.path.split('/').last}').putFile(file);

      // Get the new download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the document in Firestore
      await _firestore.collection('html_files').doc(docId).update({
        'file_name': file.path.split('/').last,
        'url': downloadUrl,
      });

      _downloadUrl = downloadUrl;
      notifyListeners();
    }
  }

  Future<void> deleteHtmlFile(String docId) async {
    await _firestore.collection('html_files').doc(docId).delete();
    _downloadUrl = null;
    notifyListeners();
  }

  Future<void> launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode
            .externalApplication, // Opens the URL in the default browser
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
