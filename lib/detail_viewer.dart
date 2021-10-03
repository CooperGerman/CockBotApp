import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/post_cock.dart';
import 'layout_manager.dart';

import 'package:flutter/material.dart';

class DetailViewer extends StatelessWidget {
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
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ingredients,
        ),
      ),
    );
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
    final topContent = Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(2.0),
      child: Center(
        child: readButton,
      ),
    );
    //------------
    // scaffold
    //------------
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${cocktail.name}'),
      ),
      body: ListView(children: <Widget>[
        Column(children: <Widget>[
          Stack(
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: <Widget>[middleContent]),
          ),
        ])
      ]),
      bottomNavigationBar: readButton,
    );
  }
}
