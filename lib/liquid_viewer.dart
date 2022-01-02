import 'physical.dart';

import 'package:flutter/material.dart';

class LiquidViewer extends StatefulWidget {
  @override
  _LiquidViewerState createState() {
    return _LiquidViewerState();
  }
}

class _LiquidViewerState extends State<LiquidViewer> {
  List<String> liquids = [];
  _LiquidViewerState() {
    fetchLiquidsList().then((val) => setState(() {
          liquids = val;
        }));
  }
  final double insetval = 10.0;
  @override
  Widget build(BuildContext context) {
    //------------
    // ingredients
    //------------
    List<Text> liqlist = [
      Text(
        'Liquids:',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    ];
    for (String liq in liquids) {
      liqlist.add(Text(
        liq,
        textAlign: TextAlign.start,
        style: const TextStyle(color: Colors.grey),
      ));
    }
    //------------
    // middle content
    //------------

    final middleContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - insetval,
      padding: EdgeInsets.all(insetval),
      color: Theme.of(context).primaryColor,
      child: Container(
          alignment: Alignment.topLeft,
          width: MediaQuery.of(context).size.width - insetval,
          child: Column(children: liqlist)),
    );
    //------------
    // scaffold
    //------------
    Text titleStr = Text(
      'Available Liquids ' +
          (cockMach.isOnline ? '' : ' (No Machine Connected)'),
      style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
    );
    return Scaffold(
      appBar: AppBar(
        title: titleStr,
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(children: <Widget>[middleContent]),
        ),
      ]),
      // bottomNavigationBar: readButton,
    );
  }
}
