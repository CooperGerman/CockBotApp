// import 'dart:math';
import 'dart:typed_data';
import 'cock.dart' as cock;

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
  _LayoutManagerState createState() {
    return new _LayoutManagerState();
  }
}

class _LayoutManagerState extends State<LayoutManager> {
  List<cock.Cocktail> _cockl = [];

  _LayoutManagerState() {
    cock.fetchCockList('vodka').then((val) => setState(() {
          _cockl = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cocktails'),
      ),
      body: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) =>
            CockView(index, _cockl.elementAt(index)),
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      ),
    );
  }
}

class CockView extends StatefulWidget {
  const CockView(this.index, this.cocktail);
  final cock.Cocktail cocktail;
  final int index;
  @override
  _CockViewState createState() {
    return _CockViewState(this.index, this.cocktail);
  }
}

class _CockViewState extends State<CockView> {
  cock.Cocktail cocktail;
  final int index;
  _CockViewState(this.index, this.cocktail) {
    cock.fetchCockDetail(this.cocktail).then((cocktail) => setState(() {
          cocktail = cocktail;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            //Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: cocktail.imgLink,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: <Widget>[
              Text(
                cocktail.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                cocktail.isAlchool,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
