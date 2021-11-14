// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'routes.dart';

List<Widget> _children = const <Widget>[
  // HomeHeaderTile('Choice', Colors.orange),
  HomeTile(
    'Available Cocktails',
    Colors.grey,
    Image(
        alignment: Alignment.center,
        fit: BoxFit.fitHeight,
        image: AssetImage('../ressources/AdobeStock_195186798-1440x960.jpeg')),
    layout_manager,
  ),
  HomeTile(
      'Available Liquids',
      Colors.grey,
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image:
              AssetImage('../ressources/pexels-chris-f-1283219-1440x960.jpg')),
      liquid_viewer),
  HomeTile(
      'Filters',
      Colors.grey,
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage(
              '../ressources/how-to-measure-a-cocktail-using-parts-760305-019-c18ecbbe4af7430fbf1442dc321aea51.jpg')),
      cock_filters),
  HomeTile(
      'Random Cock',
      Colors.grey,
      Image(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage(
              '../ressources/26665-nader-chabaane-sumino-keiko3-ok.jpg')),
      cock_filters),
  //HomeTile('test', Colors.pink, exampleTests),
];

class Home extends StatelessWidget {
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
          title: Text('CockBotApp'),
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
            children: [
              Center(child: backgroundImage),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    textScaleFactor: 2,
                    style: TextStyle(
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.white),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    textScaleFactor: 2,
                    style: TextStyle(
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
