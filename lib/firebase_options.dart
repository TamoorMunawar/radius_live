// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyB7uM6SlAsFwAbn9Et7GrQaeBKOVPt3bvc',
    appId: '1:188217877956:web:99579f73ed16843f467091',
    messagingSenderId: '188217877956',
    projectId: 'radiusapp-d0908',
    authDomain: 'radiusapp-d0908.firebaseapp.com',
    storageBucket: 'radiusapp-d0908.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPONyG-_jsO3kTnuPMQwo90kBLE6V-Ffk',
    appId: '1:188217877956:android:932b999c27102602467091',
    messagingSenderId: '188217877956',
    projectId: 'radiusapp-d0908',
    storageBucket: 'radiusapp-d0908.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3t-bPYFUlSTOFDSiCF5z-TzjIylvHvWc',
    appId: '1:188217877956:ios:96763813d5cb8f16467091',
    messagingSenderId: '188217877956',
    projectId: 'radiusapp-d0908',
    storageBucket: 'radiusapp-d0908.appspot.com',
    iosBundleId: 'com.radius.radiusvebzaapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3t-bPYFUlSTOFDSiCF5z-TzjIylvHvWc',
    appId: '1:188217877956:ios:96763813d5cb8f16467091',
    messagingSenderId: '188217877956',
    projectId: 'radiusapp-d0908',
    storageBucket: 'radiusapp-d0908.appspot.com',
    iosBundleId: 'com.radius.radiusvebzaapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB7uM6SlAsFwAbn9Et7GrQaeBKOVPt3bvc',
    appId: '1:188217877956:web:d861a19820856e9e467091',
    messagingSenderId: '188217877956',
    projectId: 'radiusapp-d0908',
    authDomain: 'radiusapp-d0908.firebaseapp.com',
    storageBucket: 'radiusapp-d0908.appspot.com',
  );
}
