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
    apiKey: 'AIzaSyCSqfFs3Hnx0bJ8BYYWk90rtmzHsxG6f8I',
    appId: '1:870445939317:web:6bb1ec0e86b08fdb56163c',
    messagingSenderId: '870445939317',
    projectId: 'course-app-4f75a',
    authDomain: 'course-app-4f75a.firebaseapp.com',
    databaseURL: 'https://course-app-4f75a-default-rtdb.firebaseio.com',
    storageBucket: 'course-app-4f75a.firebasestorage.app',
    measurementId: 'G-N5ZN67F0PS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtS_XANbQat3v4ExEU6NL0HMQDoeEcLD4',
    appId: '1:870445939317:android:d66955a06c1d71d556163c',
    messagingSenderId: '870445939317',
    projectId: 'course-app-4f75a',
    databaseURL: 'https://course-app-4f75a-default-rtdb.firebaseio.com',
    storageBucket: 'course-app-4f75a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLWYoeagy3GyQfZNT47Qr8SOQDIRHL2tU',
    appId: '1:870445939317:ios:432d8c9ef4d8679056163c',
    messagingSenderId: '870445939317',
    projectId: 'course-app-4f75a',
    databaseURL: 'https://course-app-4f75a-default-rtdb.firebaseio.com',
    storageBucket: 'course-app-4f75a.firebasestorage.app',
    iosBundleId: 'com.example.courseApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLWYoeagy3GyQfZNT47Qr8SOQDIRHL2tU',
    appId: '1:870445939317:ios:432d8c9ef4d8679056163c',
    messagingSenderId: '870445939317',
    projectId: 'course-app-4f75a',
    databaseURL: 'https://course-app-4f75a-default-rtdb.firebaseio.com',
    storageBucket: 'course-app-4f75a.firebasestorage.app',
    iosBundleId: 'com.example.courseApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCSqfFs3Hnx0bJ8BYYWk90rtmzHsxG6f8I',
    appId: '1:870445939317:web:fbe47e36fe141b0c56163c',
    messagingSenderId: '870445939317',
    projectId: 'course-app-4f75a',
    authDomain: 'course-app-4f75a.firebaseapp.com',
    databaseURL: 'https://course-app-4f75a-default-rtdb.firebaseio.com',
    storageBucket: 'course-app-4f75a.firebasestorage.app',
    measurementId: 'G-PCH0HMSE0T',
  );

}