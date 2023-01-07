import 'package:flutter/material.dart';

ThemeData theme = ThemeData.dark();

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() {
    return _SettingsViewState();
  }
}

class _SettingsViewState extends State<SettingsView> {
  final double insetval = 10.0;
  bool themeSwitch = false;
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

    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        // Body containg the settings items in a list of checkboxes and a check for updates button represented by a raised button with a circular arrow
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.amber[600],
              child: const Center(child: Text('Settings')),
            ),
            Container(
                child: Row(children: [
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: themeSwitch,
                  onChanged: (bool? value) {
                    themeSwitch = value!;
                    themeSwitch
                        ? theme = ThemeData.dark()
                        : theme = ThemeData.light();
                  }),
              Text("Set / unset all categories")
            ])),
            // Wide rectangular button
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.autorenew),
              label: Text('Check for Updates'),
            ),
          ],
        ));
  }
}
