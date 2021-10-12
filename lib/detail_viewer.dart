import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/post_cock.dart';
import 'layout_manager.dart';

import 'package:flutter/material.dart';

class DetailViewer extends StatelessWidget {
  final double insetval = 10.0;
  @override
  Widget build(BuildContext context) {
    final cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;
    //------------
    // ingredients
    //------------
    List<Text> ingredients = [
      Text(
        'Ingredients:',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    ];
    for (String ing in cocktail.ingredients) {
      ingredients.add(Text(
        ing,
        style: const TextStyle(color: Colors.grey),
      ));
    }
    //------------
    // middle content
    //------------

    final middleContent = Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(insetval),
        color: Theme.of(context).primaryColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width / 3 - insetval,
              child: Column(children: ingredients)),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 3 - insetval,
              child: Column(children: [
                Text(
                  'Instructions',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  cocktail.instructions.toString(),
                  style: const TextStyle(color: Colors.grey),
                  softWrap: true,
                )
              ])),
          Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width / 3 - insetval,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Preferred Glass',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Text(
                  cocktail.prefGlass,
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ]));
    //------------
    // bottom content
    //------------

    final readButton = Container(
        // padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              // primary: Theme.of(context).backgroundColor
              primary: Colors.orangeAccent),
          onPressed: () => {postCock(cocktail)},
          child: Text(
            "Pour this Cock !",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
    //------------
    // scaffold
    //------------
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${cocktail.name}'),
      ),
      body: ListView(children: <Widget>[
        Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: <Widget>[
                // Center(child: CircularProgressIndicator()),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: cocktail.imgLink,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(children: <Widget>[middleContent]),
          ),
        ])
      ]),
      bottomNavigationBar: readButton,
    );
  }
}
