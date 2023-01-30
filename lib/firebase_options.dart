// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-8j8dzlskV36wLQyZFVMqb0s6TiLZ6sk',
    appId: '1:728102917351:android:cf28f066fa92e025107e42',
    messagingSenderId: '728102917351',
    projectId: 'foody-37bc0',
    databaseURL: 'https://foody-37bc0-default-rtdb.firebaseio.com',
    storageBucket: 'foody-37bc0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8p1vNHqFPUlED4-KGsytfUnMp_uoFPzw',
    appId: '1:728102917351:ios:bfcfa0edce22350d107e42',
    messagingSenderId: '728102917351',
    projectId: 'foody-37bc0',
    databaseURL: 'https://foody-37bc0-default-rtdb.firebaseio.com',
    storageBucket: 'foody-37bc0.appspot.com',
    iosClientId: '728102917351-gdhe92qpqsftk5a2cfn7ufrrofcc8b17.apps.googleusercontent.com',
    iosBundleId: 'com.foody.foody',
  );
}
