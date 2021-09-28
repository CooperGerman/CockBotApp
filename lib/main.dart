import 'dart:async';
import 'dart:convert';

// import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:scroll_snap_list/scroll_snap_list.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class Cocktail {
  final String name;
  final String imgLink;
  final String desc;

  Cocktail({
    required this.name,
    required this.imgLink,
    required this.desc,
  });

  factory Cocktail.fromJson(dynamic drink) {
    return Cocktail(
      name: drink['strDrink'],
      imgLink: drink['strDrinkThumb'],
      desc: drink['idDrink'],
    );
  }
}

List<Cocktail> cockList = [];
Future<List<Cocktail>> fetchCockList(
    {List<String> filterList: const []}) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=vodka'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    for (dynamic drink in decoded['drinks']) {
      cockList.add(Cocktail.fromJson(drink));
    }

    return cockList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Cocktail list from https://www.thecocktaildb.com');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fetchCockList();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CockBOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CockList(),
    );
  }
}

class CockList extends StatefulWidget {
  @override
  _CockListState createState() => _CockListState();
}

class _CockListState extends State<CockList> {
  Map<int, bool> countToValue = <int, bool>{};
  List<Container> containerList = [];
  @override
  void initState() {
    super.initState();
    print(cockList.isEmpty);
    for (Cocktail cock in cockList) {
      print(cock);
      containerList.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.network(cock.imgLink),
          color: Colors.orangeAccent,
        ),
      );
    }
  }

  // void _onItemFocus(int index) {
  //   setState(() {
  //     _focusedIndex = index;
  //   });
  // }

  // Widget _buildCocktailDesc() {
  //   if (cockList.length > _focusedIndex)
  //     return Container(
  //       height: 25,
  //       child: Text(cockList[_focusedIndex].name),
  //     );

  //   return Container(
  //     height: 25,
  //     child: Text("No Data"),
  //   );
  // }

  // Widget _buildListItem(BuildContext context, int index) {
  //   //horizontal
  //   return Container(
  //     width: 400,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         Container(
  //           height: 500,
  //           width: MediaQuery.of(context).size.width,
  //           color: Colors.orangeAccent,
  //           child: Image.network(cockList[_focusedIndex].imgLink),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Available cocktails'),
        ),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: containerList,
              ),
            ),
          ],
        )
        // body: Container(
        //   child: Column(
        //     children: <Widget>[
        //       Expanded(
        //         child: ScrollSnapList(
        //           onItemFocus: _onItemFocus,
        //           itemSize: MediaQuery.of(context).size.width,
        //           itemBuilder: _buildListItem,
        //           itemCount: cockList.length,
        //           reverse: true,
        //           // dynamicItemSize: true,
        //         ),
        //       ),
        //       _buildCocktailDesc(),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: <Widget>[
        //           ElevatedButton(
        //             child: Text("GO !"),
        //             onPressed: () {
        //               setState(() {
        //                 // cockList.removeAt(index);
        //               });
        //             },
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
