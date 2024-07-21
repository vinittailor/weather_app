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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBobkMBFwgsZPR5PHXzzQXX2l1ypXBX7q4',
    appId: '1:874340137975:web:68d8a8a05f408452524cf2',
    messagingSenderId: '874340137975',
    projectId: 'weatherapp-9f87d',
    authDomain: 'weatherapp-9f87d.firebaseapp.com',
    storageBucket: 'weatherapp-9f87d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjzC33vYClt1AAcXZ5hzg4lFxQ23yEcws',
    appId: '1:874340137975:android:35ec152107900b92524cf2',
    messagingSenderId: '874340137975',
    projectId: 'weatherapp-9f87d',
    storageBucket: 'weatherapp-9f87d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNwNLA6mZTAkRHjsqSH_I7Xqz4ZNKzS5U',
    appId: '1:874340137975:ios:93f840fb6bbfa8fc524cf2',
    messagingSenderId: '874340137975',
    projectId: 'weatherapp-9f87d',
    storageBucket: 'weatherapp-9f87d.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );
}
