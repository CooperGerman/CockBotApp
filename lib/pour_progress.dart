// import 'dart:html';
// import 'dart:io';

import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/physical.dart';
// import 'package:cockbotapp/post_cock.dart';
import 'package:flutter/material.dart';

class PourProgress extends StatefulWidget {
  const PourProgress({Key? key}) : super(key: key);

  @override
  State<PourProgress> createState() => _PourProgressState();
}

class _PourProgressState extends State<PourProgress>
    with TickerProviderStateMixin {
  double status = 0;
  @override
  // void initState() {
  //   if (status < 1) {
  //     _PourProgressState();
  //   }
  //   super.initState();
  // }

  @override
  _PourProgressState() {
    {
      fetchPouringStatus().then((val) => setState(() {
            status = val;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Pouring ${cocktail.name}, please be patient...',
              style: TextStyle(fontSize: 20),
            ),
            LinearProgressIndicator(
              value: status,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      ),
    );
  }
}
