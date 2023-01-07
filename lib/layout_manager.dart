// import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/physical.dart';
import 'cock_filters.dart';
import 'database.dart';
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
  _LayoutManagerState createState() => _LayoutManagerState();
}

class _LayoutManagerState extends State<LayoutManager> {
  List<Cocktail> locCockDB = [];
  TextEditingController _searchTextController = new TextEditingController();
  String searchString = "";
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() {
      print(_searchTextController.text);
      searchString = _searchTextController.text;
    });
  }

  FutureOr onGoBack(dynamic value) {
    // refreshData();
  }

  void navigateFilters() {
    // Navigator.of(context).pushNamed(cock_filters).then(onGoBack);
    Route route = MaterialPageRoute(builder: (context) => CockFilters());
    Navigator.push(context, route).then(onGoBack);
  }

  Future refreshView() async {
    locCockDB = await applyFilters();
  }

  void clearSearch() {
    _searchTextController.clear();
  }

  Text titleStr = Text(
    'Cocktails ' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            controller: _searchTextController,
            // onChanged: (value) => findCock(value),
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => {clearSearch()},
                ),
                hintText: "Search...",
                border: InputBorder.none),
          ),
        ),
      )),
      body: FutureBuilder(
          future: refreshView(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                  child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      children: List.generate(locCockDB.length, (index) {
                        return CockView(locCockDB[index]);
                      })));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigateFilters(),
        label: const Text('Filters'),
        icon: const Icon(Icons.local_bar_outlined),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class CockView extends StatelessWidget {
  /// Displays the cock.
  const CockView(this.cocktail);
  final Cocktail cocktail;
  @override
  Widget build(BuildContext context) {
    Widget cockImage;
    if (cocktail.isAlcohol.contains(RegExp('non', caseSensitive: false))) {
      cockImage = Stack(
        children: <Widget>[
          Center(
            child: Image.network(
              cocktail.imgLink,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: Text('loading...'),
                );
              },
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
            child: Image.network(
              cocktail.imgLink,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: Text('loading...'),
                );
              },
            ),
          ),
        ],
      );
    }

    return cocktail.isComplete
        ? Card(
            color: Colors.lightGreen.shade300,
            child: InkWell(
                onTap: () => Navigator.of(context)
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
                onTap: () => Navigator.of(context)
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
