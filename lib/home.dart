import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'routes.dart';

const List<StaggeredTile> _tiles = <StaggeredTile>[
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(2, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(2, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(1, 1),
  // const StaggeredTile.count(2, 1),
];

List<Widget> _children = const <Widget>[
  HomeHeaderTile('Choice', Colors.orange),
  HomeTile('Cocktails', Colors.orangeAccent, layout_manager),
  HomeTile('Available Liquids', Colors.orangeAccent, liquid_viewer),
  //HomeTile('test', Colors.pink, exampleTests),
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CockBotApp'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.all(5),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            staggeredTiles: _tiles,
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
  const HomeTile(this.title, this.backgroundColor, this.route);

  final String title;
  final String route;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headline6!.copyWith(
                  color:
                      ThemeData.estimateBrightnessForColor(backgroundColor) ==
                              Brightness.dark
                          ? Colors.white
                          : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
