import 'package:cockbotapp/physical.dart';
import 'package:flutter/material.dart';

import 'cock_filters.dart';
import 'routes.dart';

class RandomCock extends StatefulWidget {
  @override
  _RandomCockState createState() {
    return _RandomCockState();
  }
}

class _RandomCockState extends State<RandomCock> {
  List<Container> categoriesBoxes = [];
  Text titleStr = Text(
    'Random cocktail ' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleStr,
      ),
      body: Center(
          child: InkWell(
              onTap: () => {
                    Navigator.of(context).pushNamed(detail_viewer,
                        arguments: getRandomizedCocks())
                  },
              child: Card(
                  color: Colors.grey,
                  child: Image(image: AssetImage('ressources/pngegg.png'))))),
    );
  }
}
