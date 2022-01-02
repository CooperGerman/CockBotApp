// import 'dart:math';
import 'dart:typed_data';
import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/physical.dart';
import 'package:cockbotapp/cock_filters.dart';
import 'routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class LayoutManager extends StatefulWidget {
  @override
  _LayoutManagerState createState() => new _LayoutManagerState();
}

class _LayoutManagerState extends State<LayoutManager> {
  List<Cocktail> _cockl = [];
  List<String> liquids = [];

  _LayoutManagerState() {
    fetchLiquidsList().then((val1) => setState(() {
          fetchCockList(val1).then((val2) => setState(() {
                _cockl = filterCockList(val2);
              }));
        }));
  }
  Text titleStr = Text(
    'Cocktails ' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    int cockLen = _cockl.length;
    return Scaffold(
      appBar: AppBar(
        title: titleStr,
      ),
      body: cockLen > 4
          ? StaggeredGridView.countBuilder(
              primary: false,
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) => index < cockLen
                  ? CockView(index, _cockl.elementAt(index))
                  : Text(''),
              staggeredTileBuilder: (index) => StaggeredTile.fit(
                  MediaQuery.of(context).size.width > 750 ? 1 : 2),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed(cock_filters),
        label: const Text('Filters'),
        icon: const Icon(Icons.local_bar_outlined),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class CockView extends StatelessWidget {
  const CockView(this.index, this.cocktail);
  final Cocktail cocktail;
  final int index;
  @override
  Widget build(BuildContext context) {
    Widget cockImage;
    if (cocktail.isAlchool.contains(RegExp('non', caseSensitive: false))) {
      cockImage = Stack(
        children: <Widget>[
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: cocktail.imgLink,
              fit: BoxFit.fitHeight,
            ),
          ),
          Image(
              alignment: Alignment.topRight,
              width: 50,
              image: AssetImage('./ressources/5627028.png'))
        ],
      );
    } else {
      cockImage = Stack(
        children: <Widget>[
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: cocktail.imgLink,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      );
    }

    return cocktail.isComplete
        ? Card(
            color: Colors.lightGreen.shade300,
            child: InkWell(
                onLongPress: () => Navigator.of(context)
                    .pushNamed(detail_viewer, arguments: cocktail),
                child: Column(
                  children: <Widget>[
                    cockImage,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Row(children: [
                            Text(
                              cocktail.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ]),
                          Text(
                            cocktail.category,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                )))
        : Card(
            child: InkWell(
                onLongPress: () => Navigator.of(context)
                    .pushNamed(detail_viewer, arguments: cocktail),
                child: Column(
                  children: <Widget>[
                    cockImage,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Text(
                            cocktail.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            cocktail.category,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
  }
}
