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
bool onlyComplete = false;
bool allowMissingNonLiquids = true;

class _CockFiltersState extends State<CockFilters> {
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

    final readButton = Container(
        // padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
          onPressed: () => Navigator.of(context).pushNamed(layout_manager),
          child: Text(
            "Apply",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Filters '),
      // ),
      body: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: ListView(children: [
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
                  Flexible(child: Text('Show only Alchool free drinks.'))
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
                      value: onlyComplete,
                      onChanged: (bool? value) {
                        setState(() {
                          onlyComplete = value!;
                        });
                      }),
                  Flexible(
                      child: Text(
                          'All ingredients must be available in the machine. (Might heavily reduce the number of displayed cocktails)'))
                ]))
          ])),
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
