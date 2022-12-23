import 'package:cockbotapp/physical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'cock_filters.dart';
import 'routes.dart';

class RandomCock extends StatefulWidget {
  @override
  _RandomCockState createState() {
    return _RandomCockState();
  }
}

class _RandomCockState extends State<RandomCock> {
  List<Container> categoriesBoxes = [];
  Text titleStr = Text(
    'Random cocktail ' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
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
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.all(5),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            staggeredTiles: tiles,
            children: [
              Card(
                color: Color(0xFF000000),
                child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(detail_viewer,
                        arguments: getRandomizedCocks()),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Center(
                            child: Image(
                                alignment: Alignment.center,
                                fit: BoxFit.fitHeight,
                                image: AssetImage('ressources/pngegg.png'))),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Randomly fetched cocktail",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Color(0xFFFFFFFF)),
                              // ..color = Colors.black),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Randomly fetched cocktail",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  foreground: Paint()
                                    // ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Color(0xA8000000)),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Card(
                color: Color(0xFF000000),
                child: InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(work_in_progress),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FittedBox(
                            fit: BoxFit.fill,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image(
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                      'ressources/blog-beakers-science.png')),
                            )),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Randomly fetched ingredients",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Color(0xFFFFFFFF)),
                              // ..color = Colors.black),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Randomly fetched ingredients",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  foreground: Paint()
                                    // ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Color(0xA8000000)),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        )));
  }
}



// List(
//             child: Column(children: [
//           Center(
//               child: InkWell(
//                   onTap: () => {
//                         Navigator.of(context).pushNamed(detail_viewer,
//                             arguments: getRandomizedCocks())
//                       },
//                   child: Card(
//                       color: Colors.grey,
//                       child:
//                           Image(image: AssetImage('ressources/pngegg.png'))))),
//           Center(
//               child: InkWell(
//                   onTap: () => {
//                         Navigator.of(context).pushNamed(detail_viewer,
//                             arguments: getRandomizedCocks())
//                       },
//                   child: Card(
//                       color: Colors.grey,
//                       child:
//                           Image(image: AssetImage('ressources/pngegg.png'))))),
//         ])));