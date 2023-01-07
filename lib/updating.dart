import 'package:flutter/material.dart';

import 'database.dart';

class Updating extends StatefulWidget {
  @override
  _UpdatingState createState() {
    return _UpdatingState();
  }
}

class _UpdatingState extends State<Updating> {
  final double insetval = 10.0;

  void popNavigator() {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: updateDB(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // updateDB has finished
                // Pop navigator
                popNavigator();
                return Center(
                    child: Text(
                  "Cocktail database updated",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      foreground: Paint()
                        ..strokeWidth = 1
                        ..color = Colors.lightBlueAccent),
                ));
              } else {
                // updateDB is still running
                return Column(children: [
                  Center(
                      child: Text(
                    "Updating cocktail database... ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        foreground: Paint()
                          ..strokeWidth = 1
                          ..color = Colors.lightBlueAccent),
                  )),
                  Center(child: CircularProgressIndicator())
                ]);
              }
            }));
  }
}
