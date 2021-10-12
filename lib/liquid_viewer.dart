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
    // final cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;
    //------------
    // ingredients
    //------------
    List<Text> liqlist = [
      Text(
        'Liquids:',
        style: const TextStyle(fontWeight: FontWeight.bold),
        // textAlign: TextAlign.left,
      ),
    ];
    for (String liq in liquids) {
      liqlist.add(Text(
        liq,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Liquids '),
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
