import 'cock.dart' as cock;
import 'layout_manager.dart';

import 'package:flutter/material.dart';

class DetailViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cocktail =
        ModalRoute.of(context)!.settings.arguments as cock.Cocktail;
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
    // scaffold
    //------------
    return Scaffold(
        appBar: AppBar(
          title: Text('Details for ${cocktail.name}'),
        ),
        body: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: cocktail.imgLink,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ingredients),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       Text(
                //         cocktail.name,
                //         style: const TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       Text(
                //         cocktail.isAlchool,
                //         style: const TextStyle(color: Colors.grey),
                //       ),
                //     ])
              ],
            ),
          ),
        ]));
  }
}
