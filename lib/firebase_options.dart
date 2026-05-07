// PLACEHOLDER: This file must be replaced by running:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// The above command will generate the correct DefaultFirebaseOptions
// for your Firebase project and overwrite this file.
//
// See: https://firebase.flutter.dev/docs/overview

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web. '
        'Run: flutterfire configure',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform. '
          'Run: flutterfire configure',
        );
    }
  }

  // TODO: Replace with real values from `flutterfire configure`
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'PLACEHOLDER_API_KEY',
    appId: 'PLACEHOLDER_APP_ID',
    messagingSenderId: 'PLACEHOLDER_SENDER_ID',
    projectId: 'PLACEHOLDER_PROJECT_ID',
    storageBucket: 'PLACEHOLDER_STORAGE_BUCKET',
  );

  // TODO: Replace with real values from `flutterfire configure`
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'PLACEHOLDER_API_KEY',
    appId: 'PLACEHOLDER_APP_ID',
    messagingSenderId: 'PLACEHOLDER_SENDER_ID',
    projectId: 'PLACEHOLDER_PROJECT_ID',
    storageBucket: 'PLACEHOLDER_STORAGE_BUCKET',
    iosClientId: 'PLACEHOLDER_IOS_CLIENT_ID',
    iosBundleId: 'com.example.scanBi',
  );
}
