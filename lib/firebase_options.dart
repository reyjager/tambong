// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-V5dkgWvYgb0gzTLobTEQ8nQLvMNYnLU',
    appId: '1:180769827804:web:4391809499ae84bfc9fd19',
    messagingSenderId: '180769827804',
    projectId: 'fir-sample-c29d9',
    authDomain: 'fir-sample-c29d9.firebaseapp.com',
    databaseURL:
        'https://fir-sample-c29d9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-sample-c29d9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWeE1xhgcGon_g48MUDSoOAEr0EkB1kj8',
    appId: '1:180769827804:android:ee2937cb3d1c6540c9fd19',
    messagingSenderId: '180769827804',
    projectId: 'fir-sample-c29d9',
    databaseURL:
        'https://fir-sample-c29d9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-sample-c29d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEUts8Dj1EO5mx6IYBePImv4HLpRxBPYs',
    appId: '1:180769827804:ios:83a2069c774b1ca7c9fd19',
    messagingSenderId: '180769827804',
    projectId: 'fir-sample-c29d9',
    databaseURL:
        'https://fir-sample-c29d9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-sample-c29d9.appspot.com',
    iosBundleId: 'com.example.tambong',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEUts8Dj1EO5mx6IYBePImv4HLpRxBPYs',
    appId: '1:180769827804:ios:83a2069c774b1ca7c9fd19',
    messagingSenderId: '180769827804',
    projectId: 'fir-sample-c29d9',
    databaseURL:
        'https://fir-sample-c29d9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-sample-c29d9.appspot.com',
    iosBundleId: 'com.example.tambong',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-V5dkgWvYgb0gzTLobTEQ8nQLvMNYnLU',
    appId: '1:180769827804:web:4391809499ae84bfc9fd19',
    messagingSenderId: '180769827804',
    projectId: 'fir-sample-c29d9',
    authDomain: 'fir-sample-c29d9.firebaseapp.com',
    databaseURL:
        'https://fir-sample-c29d9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'fir-sample-c29d9.appspot.com',
  );
}
