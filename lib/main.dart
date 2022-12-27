import 'package:flutter/material.dart';
import 'routes.dart';
import 'cockHiveDb.dart';
import 'package:provider/provider.dart';

void main() async {
  final database = CocktailDatabase();
  runApp(
    Provider<CocktailDatabase>(
      create: (_) => database,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CockBotApp',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
