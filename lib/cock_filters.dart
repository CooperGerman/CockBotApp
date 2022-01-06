import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/routes.dart';
import 'package:flutter/material.dart';

class CockFilters extends StatefulWidget {
  @override
  _CockFiltersState createState() {
    return _CockFiltersState();
  }
}

bool noAlchool = false;
Map categories = {
  "Ordinary Drink": false,
  "Cocktail": false,
  "Milk / Float / Shake": false,
  "Other/Unknown": false,
  "Cocoa": false,
  "Shot": false,
  "Coffee / Tea": false,
  "Homemade Liqueur": false,
  "Punch / Party Drink": true,
  "Beer": false,
  "Soft Drink / Soda": false
};
bool onlyComplete = false;
bool allowMissingNonLiquids = true;
bool containsLiquid = true;

class _CockFiltersState extends State<CockFilters> {
  List<Container> categoriesBoxes = [];
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    //##########################################################################
    // Apply button
    //##########################################################################
    //reinitilaize the list after refresh so it does not accumulate
    categoriesBoxes = [
      Container(
          child: Text('Categories',
              style: const TextStyle(fontWeight: FontWeight.bold)))
    ];
    for (String cat in categories.keys) {
      categoriesBoxes.add(Container(
          child: Row(children: [
        Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: categories[cat],
            onChanged: (bool? value) {
              setState(() {
                categories[cat] = value!;
              });
            }),
        Text(cat)
      ])));
    }
    Widget categoriesW = Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey.shade800,
        alignment: Alignment.topCenter,
        child: Column(children: categoriesBoxes));
    //##########################################################################
    // Apply button
    //##########################################################################
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
        title: Text('Filters '),
      ),
      body: ListView(children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: noAlchool,
                  onChanged: (bool? value) {
                    setState(() {
                      noAlchool = value!;
                    });
                  }),
              Flexible(
                  child: Row(children: [
                Text('Show only Alchool free drinks '),
                Text(
                  '(Caution using this option might cause sobriety)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                ),
                Text('.'),
              ]))
            ])),
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: allowMissingNonLiquids,
                  onChanged: (bool? value) {
                    setState(() {
                      allowMissingNonLiquids = value!;
                    });
                  }),
              Flexible(
                  child: Text(
                      'Allow missing non-liquids. This option enables to extend cocktail research with cocktails lacking non liquid ingredients such as sugar, salt, lemon scratches ... Those could indeed be added manually afterwards.',
                      softWrap: true))
            ])),
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: containsLiquid,
                  onChanged: (bool? value) {
                    setState(() {
                      containsLiquid = value!;
                    });
                  }),
              Flexible(
                  child: Text(
                      'If ticked, only drinks that contain at least one liquid from the machine will be shown. (This aims at drastically narrowing down the search scope)',
                      softWrap: true))
            ])),
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: onlyComplete,
                  onChanged: (bool? value) {
                    setState(() {
                      onlyComplete = value!;
                    });
                  }),
              Flexible(
                  child: Text(
                      'All ingredients must be available in the machine. (Might heavily reduce the number of displayed cocktails)'))
            ])),
        categoriesW
      ]),
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
