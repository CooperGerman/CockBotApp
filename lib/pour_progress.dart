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
  String tag = '';
  String name = '';
  bool finished = false;
  @override
  _PourProgressState() {
    {
      fetchPouringStatus().then((val) => setState(() {
            if (val['tag'] != null) {
              tag = val['tag'];
            }
            if (val['name'] != null) {
              status = val['status'];
              name = val['name'];
            }
          }));
    }
  }
  _update() {
    {
      Future.delayed(Duration(seconds: 1))
          .then((val) => fetchPouringStatus().then((val) => setState(() {
                if (val['name'] != null) {
                  tag = val['tag'];
                }
                if (val['name'] != null) {
                  status = val['status'];
                  name = val['name'];
                }
              })));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;
    Widget displayed;
    if (!finished) {
      this._update();
    }
    if (cocktail.name == name && cocktail.tag == tag) {
      displayed = Column(
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
      );
      if (status == 1) {
        finished = true;
        displayed = FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pop(),
          label: const Text('Return'),
          icon: const Icon(Icons.keyboard_return),
          backgroundColor: Colors.orangeAccent,
        );
      }
    } else {
      displayed = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Pouring ${cocktail.name}, please be patient...',
            style: TextStyle(fontSize: 20),
          ),
          LinearProgressIndicator(
            value: 0,
            semanticsLabel: 'Linear progress indicator',
          ),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0), child: displayed),
    );
  }
}
