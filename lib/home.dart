import 'package:cockbotapp/physical.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'cock.dart';
import 'routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_database/firebase_database.dart';

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
  // _HomeState() {
  //   // Wait for fetchLiquidList to complete
  //   fetchLiquidsList().then((val1) => (() {
  //         fetchCockList(val1);
  //       }));
  // }

  Text titleStr = Text(
    'CockBotApp' + (cockMach.isOnline ? '' : ' (No Machine Connected)'),
    style: TextStyle(color: cockMach.isOnline ? Colors.white : Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    List<StaggeredGridTile> tiles = <StaggeredGridTile>[
      StaggeredGridTile.count(
        crossAxisCellCount: (MediaQuery.of(context).size.width > 750 ? 1 : 2),
        mainAxisCellCount:
            (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6),
        child: _children[0],
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: (MediaQuery.of(context).size.width > 750 ? 1 : 2),
        mainAxisCellCount:
            (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6),
        child: _children[1],
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: (MediaQuery.of(context).size.width > 750 ? 1 : 2),
        mainAxisCellCount:
            (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6),
        child: _children[2],
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: (MediaQuery.of(context).size.width > 750 ? 1 : 2),
        mainAxisCellCount:
            (MediaQuery.of(context).size.width > 750 ? 0.74 : 1.6),
        child: _children[3],
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: titleStr,
        ),
        body: FutureBuilder(
            future: updateDB(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    // padding: const EdgeInsets.all(5),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: tiles,
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
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
                    title,
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
    );
  }
}

Future<void> updateDB() async {
  // Initialize Firebase
  FirebaseDatabase _database = FirebaseDatabase.instance;
  // FirebaseApp secondaryApp = Firebase.app('CockBotApp');
  // FirebaseDatabase _database = FirebaseDatabase.instanceFor(
  //     app: secondaryApp,
  //     databaseURL:
  //         'https://cockbotappdb-default-rtdb.europe-west1.firebasedatabase.app/');

  // Wait for fetchLiquidList to complete
  await fetchLiquidsList().then((val1) async {
    await fetchCockList(val1);
  });

  // Loop through the list and add each Cocktail object to the Firebase database
  for (var cocktail in cockList.elements) {
    // Check if the cocktail already exists in the database
    var snapshot = await _database
        .ref('cocktails')
        .orderByChild('name')
        .equalTo(cocktail.name)
        .once(DatabaseEventType.value)
        .timeout(Duration(seconds: 5));
    if (snapshot.snapshot.value == null) {
      // Cocktail does not exist, add it to the database
      await _database
          .ref('cocktails')
          .push()
          .set(cocktail.toMap())
          .then((_) {
            // Data saved successfully!
            print('Pushed ' + cocktail.name + ' sucessfully');
          })
          .timeout(Duration(seconds: 5))
          .catchError((error) {
            // The write failed...
            print(cocktail.name + ' push failed');
          });
    } else {
      // compare local and remote cocktail objects
      // if they are different, update the remote cocktail object
      // else do nothing
      var __cocktail =
          Map<String, dynamic>.from(snapshot.snapshot.value as Map);
      for (var key in __cocktail.keys) {
        if (cocktail.toMap().containsKey(key) &&
            cocktail.toMap()[key] != __cocktail[key]) {
          print('Updating field ' + cocktail.name);
          await _database.ref('cocktails').child(key).update(cocktail.toMap());
        } else {
          // Cocktail already exists, skip adding it
          print('Field ' +
              key +
              'of' +
              cocktail.name +
              ' is unchanged, skipping');
        }
      }
    }
  }
}
