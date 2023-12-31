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
    apiKey: 'AIzaSyBZrs3P3cB5kV9zLcbe4VZZlu4PQ3dkozg',
    appId: '1:363399310715:web:644defce1b5677b50121de',
    messagingSenderId: '363399310715',
    projectId: 'clone-cf0c8',
    authDomain: 'clone-cf0c8.firebaseapp.com',
    storageBucket: 'clone-cf0c8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmOUTYZvL-HpcjkhhY3TAMMTorJOwDzjs',
    appId: '1:363399310715:android:f219d453378f2f740121de',
    messagingSenderId: '363399310715',
    projectId: 'clone-cf0c8',
    storageBucket: 'clone-cf0c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpFs38jor-Rr_C3-STtcPf-lko-HR9Eio',
    appId: '1:363399310715:ios:c6d95b14db6709460121de',
    messagingSenderId: '363399310715',
    projectId: 'clone-cf0c8',
    storageBucket: 'clone-cf0c8.appspot.com',
    iosClientId: '363399310715-cdmnijt7uudu2jnfv9eh1qis5l3mm5ur.apps.googleusercontent.com',
    iosBundleId: 'com.example.instragramFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpFs38jor-Rr_C3-STtcPf-lko-HR9Eio',
    appId: '1:363399310715:ios:c6d95b14db6709460121de',
    messagingSenderId: '363399310715',
    projectId: 'clone-cf0c8',
    storageBucket: 'clone-cf0c8.appspot.com',
    iosClientId: '363399310715-cdmnijt7uudu2jnfv9eh1qis5l3mm5ur.apps.googleusercontent.com',
    iosBundleId: 'com.example.instragramFirebase',
  );
}
