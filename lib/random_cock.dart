import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/routes.dart';
import 'package:cockbotapp/physical.dart';
import 'package:flutter/material.dart';

class RandomCock extends StatefulWidget {
  @override
  _RandomCockState createState() {
    return _RandomCockState();
  }
}

class _RandomCockState extends State<RandomCock> {
  List<Container> categoriesBoxes = [];
  @override
  Text titleStr = Text(
    'Random cocktail ' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );
  Widget build(BuildContext context) {
    final readButton = Container(
        // padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
          onPressed: () =>
              {Navigator.of(context).pushReplacementNamed(layout_manager)},
          child: Text(
            "Apply",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        title: titleStr,
      ),
      body: Center(
          child: InkWell(
              child: Card(
                  color: Colors.grey,
                  child:
                      Image(image: AssetImage('../ressources/pngegg.png'))))),
      bottomNavigationBar: readButton,
    );
  }
}

List<Cocktail> filterCockList(List<Cocktail> cockL) {
  List<Cocktail> res = [];
  for (Cocktail cock in cockL) {
    if (cock.isToBeDisplayed()) {
      res.add(cock);
    }
  }
  return res;
}
