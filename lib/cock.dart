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
  String isAlcohol = '';
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
        !(this.isAlcohol.contains(RegExp('non', caseSensitive: false)))) {
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgLink': imgLink,
      'id': id,
      'isComplete': isComplete,
      'isAlcohol': isAlcohol,
      'tag': tag,
      'prefGlass': prefGlass,
      'category': category,
      'instructions': instructions,
      'ingredients': ingredients,
      'missing': missing,
      'measures': measures,
      'display': display,
    };
  }

  factory Cocktail.fromMap(Map<String, dynamic> map) {
    Cocktail cock =
        Cocktail(name: map['name'], imgLink: map['imgLink'], id: map['id']);
    if (map.isNotEmpty) {
      map.containsKey('isComplete')
          ? cock.isComplete = map['isComplete']
          : cock.isComplete = cock.isComplete;
      map.containsKey('isAlcohol')
          ? cock.isAlcohol = map['isAlcohol']
          : cock.isAlcohol = cock.isAlcohol;
      map.containsKey('tag') ? cock.tag = map['tag'] : cock.tag = cock.tag;
      map.containsKey('prefGlass')
          ? cock.prefGlass = map['prefGlass']
          : cock.prefGlass = cock.prefGlass;
      map.containsKey('category')
          ? cock.category = map['category']
          : cock.category = cock.category;
      map.containsKey('instructions')
          ? cock.instructions = map['instructions']
          : cock.instructions = cock.instructions;
      map.containsKey('ingredients')
          ? cock.ingredients = List<String>.from(map['ingredients'])
          : cock.ingredients = cock.ingredients;
      map.containsKey('missing')
          ? cock.missing = List<String>.from(map['missing'])
          : cock.missing = cock.missing;
      map.containsKey('measures')
          ? cock.measures = List<String>.from(map['measures'])
          : cock.measures = cock.measures;
      map.containsKey('display')
          ? cock.display = map['display']
          : cock.display = cock.display;
    } else {
      Exception('Map empty');
    }
    return cock;
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
  List<Cocktail> search = [];

  CockList() {
    Cocktail waterCocktail = Cocktail(
        name: 'debug water',
        imgLink:
            'https://i.guim.co.uk/img/media/eda873838f940582d1210dcf51900efad3fa8c9b/0_469_7360_4417/master/7360.jpg?width=1140&quality=85&dpr=1&s=none',
        id: '0');
    waterCocktail.ingredients = ['Water'];
    waterCocktail.measures = ['10 cl'];

    this.elements.add(waterCocktail);
    this.filtered.clear();
    this.search.clear();
  }

  applyFilters() {
    for (var cock in this.elements) {
      cock.isToBeDisplayed();
    }
  }

  filterDisplayed() {
    this.filtered.clear();
    for (var cock in this.elements) {
      if (cock.display && !this.isInCockList(this.filtered, cock)) {
        this.filtered.add(cock);
      }
    }
    return this.filtered;
  }

  bool isInCockList(List list, Cocktail val) {
    for (var cock in list) {
      if (val.name == cock.name) {
        return true;
      }
    }
    return false;
  }

  findCock(String filter) {
    if (filter == "") {
      applyFilters();
      return this.filtered;
    }
    this.search.clear();
    for (var cock in this.filtered) {
      if (cock.name.toLowerCase().contains(filter.toLowerCase()) &&
          !this.isInCockList(this.search, cock)) {
        this.search.add(cock);
      }
    }
    return this.search;
  }
}

Future<CockList> fetchCockList(List<String> ingredients) async {
  CockList cockList = CockList();
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
        // check that response status is 200
        print(add + " fetched sucessfully");
        if (decoded.keys.isNotEmpty) {
          if (decoded['drinks'].length > 0) {
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
        print(add + " fetched sucessfully");
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
  }
  cockList.filterDisplayed();
  return cockList;
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
    cocktail.isAlcohol = decoded['drinks'][0]['strAlcoholic'];
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
