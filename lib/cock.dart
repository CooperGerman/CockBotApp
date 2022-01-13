import 'dart:async';
import 'physical.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:cockbotapp/cock_filters.dart';

class Cocktail {
  final String name;
  final String imgLink;
  final String id;
  bool isComplete = false;
  String isAlchool = '';
  String tag = Uuid().v4();
  String prefGlass = '';
  String category = '';
  String instructions = '';
  List<String> ingredients = [];
  List<String> missing = [];
  List<String> measures = [];
  bool display = true;

  Cocktail({
    required this.name,
    required this.imgLink,
    required this.id,
  });
  isToBeDisplayed() {
    this.display = true;
    if (cockFiltVals.noAlchool &
        !(this.isAlchool.contains(RegExp('non', caseSensitive: false)))) {
      this.display = false;
    }
    if (cockFiltVals.onlyComplete & !this.isComplete) {
      this.display = false;
    }
    if (cockFiltVals.containsLiquid) {
      bool tmp = false;
      for (var ing in this.ingredients) {
        if (cockMach.liquids.contains(ing)) {
          tmp = true;
        }
      }
      this.display = tmp;
    }
    if (cockFiltVals.categories[this.category] == false) {
      this.display = false;
    }
  }

  factory Cocktail.fromJson(dynamic drink) {
    return Cocktail(
      name: drink['strDrink'],
      imgLink: drink['strDrinkThumb'],
      id: drink['idDrink'],
    );
  }
}

class CockList {
  final List<Cocktail> elements = [];
  List<Cocktail> filtered = [];

  filterDisplayed() {
    this.filtered.clear();
    for (var cock in this.elements) {
      cock.isToBeDisplayed();
      if (cock.display && !this.isInCockList(this.filtered, cock)) {
        this.filtered.add(cock);
      }
    }
    print('number of elements : ${(this.elements).length}');
    print('number of filtered : ${(this.filtered).length}');
  }

  bool isInCockList(List list, Cocktail val) {
    for (var cock in list) {
      if (val.name == cock.name) {
        return true;
      }
    }
    return false;
  }
}

CockList cockList = CockList();

fetchCockList(List<String> ingredients) async {
  Cocktail cock;
  if (!ingredients.contains('*')) {
    for (var ingredient in ingredients) {
      String add = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
          ingredient;
      try {
        final response = await Dio().get(add).timeout(Duration(seconds: 10));
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // Map decoded = jsonDecode(response.data);
        Map decoded = (response.data);
        if (decoded.keys.isNotEmpty) {
          if (decoded['drinks'].length) {
            for (dynamic drink in decoded['drinks']) {
              cock = Cocktail.fromJson(drink);
              cock.isToBeDisplayed();
              fetchCockDetail(cock, ingredients).then((val) =>
                  cockList.isInCockList(cockList.elements, val)
                      ? null
                      : cockList.elements.add(val));
            }
            for (cock in cockList.elements) {
              if (cock.missing.isEmpty) {
                cock.isComplete = true;
              }
            }
          }
        }
      } on DioError catch (e) {
        if (e.response == null) {
          print(add + " not reachable");
        } else if (e.type.toString() == "response") {
          print(add + " responded incorrect status");
        } else if (e.type.toString() == "cancel") {
          print(add + " cancelled");
        } else if (e.type.toString() == "connectTimeout") {
          print(add + " connection timed out");
        } else if (e.type.toString() == "cancel") {
          print(add + " cancelled");
        }
      }
    }
  } else {
    int c = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      String add = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?f=' +
          String.fromCharCode(c);
      try {
        final response = await Dio().get(add).timeout(Duration(seconds: 10));
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Map decoded = response.data;
        if (decoded.keys.isNotEmpty) {
          if (decoded.values.first != null) {
            for (dynamic drink in decoded['drinks']) {
              cock = Cocktail.fromJson(drink);
              cock.isToBeDisplayed();
              fetchCockDetail(cock, ingredients).then((val) =>
                  cockList.isInCockList(cockList.elements, val)
                      ? null
                      : cockList.elements.add(val));
            }
            for (cock in cockList.elements) {
              if (cock.missing.isEmpty) {
                cock.isComplete = true;
              }
            }
          }
        }
      } on DioError catch (e) {
        if (e.response == null) {
          print(add + " not reachable");
        } else if (e.type.toString() == "response") {
          print(add + " responded incorrect status");
        } else if (e.type.toString() == "cancel") {
          print(add + " cancelled");
        } else if (e.type.toString() == "connectTimeout") {
          print(add + " connection timed out");
        } else if (e.type.toString() == "cancel") {
          print(add + " cancelled");
        }
      }
      c++;
    }

    // for (var i = 0; i < 10; i++) {
    //   String add = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
    //       i.toString();
    //   try {
    //     final response = await Dio().get(add).timeout(Duration(seconds: 10));
    //     // If the server did return a 200 OK response,
    //     // then parse the JSON.
    //     // Map decoded = jsonDecode(response.data);
    //     print(response);
    //     Map decoded = response.data;
    //     if (decoded.keys.isNotEmpty) {
    //       if (decoded.values.first != null) {
    //         for (dynamic drink in decoded['drinks']) {
    //           cock = Cocktail.fromJson(drink);
    //           cock.isToBeDisplayed();
    //           fetchCockDetail(cock, ingredients).then((val) =>
    //               cockList.isInCockList(cockList.elements, val) ? null : cockList.add(val));
    //         }
    //         for (cock in cockList) {
    //           if (cock.missing.isEmpty) {
    //             cock.isComplete = true;
    //           }
    //         }
    //       }
    //     }
    //   } on DioError catch (e) {
    //     if (e.response == null) {
    //       print(add + " not reachable");
    //     } else if (e.type == "response") {
    //       print(add + " responded incorrect status");
    //     } else if (e.type == "cancel") {
    //       print(add + " cancelled");
    //     } else if (e.type == "connectTimeout") {
    //       print(add + " connection timed out");
    //     } else if (e.type == "cancel") {
    //       print(add + " cancelled");
    //     }
    //   }
    // }
  }
  cockList.filterDisplayed();
}

Future<Cocktail> fetchCockDetail(
    Cocktail cocktail, List<String> ingredients) async {
  String add =
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' + cocktail.id;
  try {
    final response = await Dio().get(add).timeout(Duration(seconds: 10));
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // Map decoded = jsonDecode(response.data);
    // print(add);
    Map decoded = (response.data);
    String ing = "";
    // 16 because of hardcoded number of ingredients
    cocktail.isAlchool = decoded['drinks'][0]['strAlcoholic'];
    cocktail.prefGlass = decoded['drinks'][0]['strGlass'];
    cocktail.category = decoded['drinks'][0]['strCategory'];
    cocktail.instructions = decoded['drinks'][0]['strInstructions'];
    if (decoded.keys.isNotEmpty) {
      // print(add);
      if (decoded.values.first != null) {
        for (var i = 1; i < 16; i++) {
          if (decoded['drinks'][0]['strIngredient' + i.toString()] != null) {
            ing = decoded['drinks'][0]['strIngredient' + i.toString()];

            if (ingredients.contains(ing)) {
              cocktail.ingredients.add(ing);
            } else {
              cocktail.missing.add(ing);
            }
          }
          if (decoded['drinks'][0]['strMeasure' + i.toString()] != null) {
            cocktail.measures
                .add(decoded['drinks'][0]['strMeasure' + i.toString()]);
          }
        }
      }
    }
  } on DioError catch (e) {
    if (e.response == null) {
      print(add + " not reachable");
    } else if (e.type.toString() == "response") {
      print(add + " responded incorrect status");
    } else if (e.type.toString() == "cancel") {
      print(add + " cancelled");
    } else if (e.type.toString() == "connectTimeout") {
      print(add + " connection timed out");
    } else if (e.type.toString() == "cancel") {
      print(add + " cancelled");
    }
  }
  return cocktail;
}
