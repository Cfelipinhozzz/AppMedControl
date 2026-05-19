import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyCaopoYjQr5xvUElzw6V4AMS8vpd0bjnmA',
    appId: '1:198673168561:web:afbbb53508b2ad10c20a90',
    messagingSenderId: '198673168561',
    projectId: 'appflutter-483b8',
    authDomain: 'appflutter-483b8.firebaseapp.com',
    storageBucket: 'appflutter-483b8.firebasestorage.app',
    measurementId: 'G-51PXPL3QP1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7cv324DM8thzlbDNaPRxhKUnlRxPlTGQ',
    appId: '1:198673168561:android:ab18b2d19403d6d8c20a90',
    messagingSenderId: '198673168561',
    projectId: 'appflutter-483b8',
    storageBucket: 'appflutter-483b8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5imjVUws7Ez3mAfNQr_nMKR2EE2Q0eME',
    appId: '1:198673168561:ios:ef7f1ec2a87cfa82c20a90',
    messagingSenderId: '198673168561',
    projectId: 'appflutter-483b8',
    storageBucket: 'appflutter-483b8.firebasestorage.app',
    iosBundleId: 'com.example.medcontrol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5imjVUws7Ez3mAfNQr_nMKR2EE2Q0eME',
    appId: '1:198673168561:ios:ef7f1ec2a87cfa82c20a90',
    messagingSenderId: '198673168561',
    projectId: 'appflutter-483b8',
    storageBucket: 'appflutter-483b8.firebasestorage.app',
    iosBundleId: 'com.example.medcontrol',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaopoYjQr5xvUElzw6V4AMS8vpd0bjnmA',
    appId: '1:198673168561:web:6597ec9e50f0eafcc20a90',
    messagingSenderId: '198673168561',
    projectId: 'appflutter-483b8',
    authDomain: 'appflutter-483b8.firebaseapp.com',
    storageBucket: 'appflutter-483b8.firebasestorage.app',
    measurementId: 'G-Y7CF54QTGH',
  );
}
