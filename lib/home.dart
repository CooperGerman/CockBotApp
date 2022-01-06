// import 'dart:io';

import 'dart:html';

import 'package:cockbotapp/physical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'routes.dart';
import 'physical.dart';

List<Widget> _children = const <Widget>[
  // HomeHeaderTile('Choice', Colors.orange),
  HomeTile(
    'Available Cocktails',
    Color(0xFF000000),
    Image(
        alignment: Alignment.center,
        fit: BoxFit.fitHeight,
        image: AssetImage('ressources/AdobeStock_195186798-1440x960.jpeg')),
    layout_manager,
  ),
  HomeTile(
      'Available Liquids',
      Color(0xFF000000),
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage('ressources/pexels-chris-f-1283219-1440x960.jpg')),
      liquid_viewer),
  HomeTile(
      'Filters',
      Color(0xFF000000),
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage(
              'ressources/how-to-measure-a-cocktail-using-parts-760305-019-c18ecbbe4af7430fbf1442dc321aea51.jpg')),
      cock_filters),
  HomeTile(
      'Random Cocktail',
      Color(0xFF000000),
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage(
              'ressources/26665-nader-chabaane-sumino-keiko3-ok.jpg')),
      rand_cock),
  //HomeTile('test', Colors.pink, exampleTests),
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  // String titleStr = 'CockBotApp' + (cockMach.isOnline ? '' : " (No Machine Connected)");
  Text titleStr = Text(
    'CockBotApp' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    List<StaggeredTile> tiles = <StaggeredTile>[
      StaggeredTile.count((MediaQuery.of(context).size.width > 750 ? 1 : 2),
          (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6)),
      StaggeredTile.count((MediaQuery.of(context).size.width > 750 ? 1 : 2),
          (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6)),
      StaggeredTile.count((MediaQuery.of(context).size.width > 750 ? 1 : 2),
          (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6)),
      StaggeredTile.count((MediaQuery.of(context).size.width > 750 ? 1 : 2),
          (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6)),
    ];
    return Scaffold(
        appBar: AppBar(
          title: titleStr,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.all(5),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            staggeredTiles: tiles,
            children: _children,
          ),
        ));
  }
}

class HomeHeaderTile extends StatelessWidget {
  const HomeHeaderTile(this.title, this.backgroundColor);

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: backgroundColor,
      ))),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .headline6!
                .copyWith(color: backgroundColor),
          ),
        ),
      ),
    );
  }
}

class HomeTile extends StatelessWidget {
  const HomeTile(
      this.title, this.backgroundColor, this.backgroundImage, this.route);

  final String title;
  final Image backgroundImage;
  final String route;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(route),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(child: backgroundImage),
              FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          // ..color = Colors.white),
                          ..color = Colors.black),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        foreground: Paint()
                          // ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Color(0xFF91521F)),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
