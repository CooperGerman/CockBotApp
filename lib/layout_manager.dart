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

// List<IntSize> _createSizes(int count) {
//   final rnd = Random();
//   return List.generate(
//       count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
// }

List<cock.Cocktail> _createCockList(String ingredient) {
  cock.fetchCockList(ingredient);
  return cock.cockList;
}

class LayoutManager extends StatelessWidget {
  // LayoutManager() : _sizes = _createSizes(_kItemCount).toList();
  LayoutManager() : _cockl = _createCockList('vodka').toList();

  // static const int _kItemCount = 20;
  // final List<IntSize> _sizes;
  final List<cock.Cocktail> _cockl;

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
        // itemBuilder: (context, index) => _Tile(index, _sizes[index]),
        itemBuilder: (context, index) => _Tile(index, _cockl.elementAt(index)),
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      ),
    );
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  // const _Tile(this.index, this.size);
  const _Tile(this.index, this.cocktail);

  // final IntSize size;
  final cock.Cocktail cocktail;
  final int index;

  @override
  Widget build(BuildContext context) {
    cock.fetchCockDetail(cocktail);
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
      ),
    );
  }
}
