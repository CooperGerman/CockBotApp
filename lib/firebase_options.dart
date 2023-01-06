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
    apiKey: 'AIzaSyApHQCAygYnoaBNFvn-kzGDg8Rq-bSfp5o',
    appId: '1:656021822180:web:793b3b02e83964d2b46af1',
    messagingSenderId: '656021822180',
    projectId: 'cockbotappdb',
    authDomain: 'cockbotappdb.firebaseapp.com',
    storageBucket: 'cockbotappdb.appspot.com',
    measurementId: 'G-NH0KCN92D9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQ_9pgToodE6s2Hbjij90haVho3YsRyZY',
    appId: '1:656021822180:android:dba7283e311410fab46af1',
    messagingSenderId: '656021822180',
    projectId: 'cockbotappdb',
    storageBucket: 'cockbotappdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDx5OXhKOt8UfqUu2ZvQfDu7_k8T8lY8UE',
    appId: '1:656021822180:ios:12597cd5b8dc3abbb46af1',
    messagingSenderId: '656021822180',
    projectId: 'cockbotappdb',
    storageBucket: 'cockbotappdb.appspot.com',
    iosClientId: '656021822180-kleedsccgevaq2p6f5hmum24msqtr84i.apps.googleusercontent.com',
    iosBundleId: 'com.example.CockBotApp',
  );
}