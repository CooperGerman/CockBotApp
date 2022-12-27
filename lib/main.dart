import 'package:flutter/material.dart';
import 'routes.dart';
import 'cock.dart';
import 'cockHiveDb.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.openBox<Cocktail>('cocktailDatabase');
  final database =
      CocktailDatabase(box: Hive.box<Cocktail>('cocktailDatabase'));
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
