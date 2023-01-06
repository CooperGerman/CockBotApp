import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  // Initialize Firebase
  await Firebase.initializeApp(name: "CockBotApp",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CockBotApp',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
