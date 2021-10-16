import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cockbotapp/cock_filters.dart' as cockf;

class Cocktail {
  final String name;
  final String imgLink;
  final String id;
  bool isComplete = false;
  String isAlchool = '';
  String prefGlass = '';
  String instructions = '';
  List<String> ingredients = [];
  List<String> missing = [];
  List<String> measures = [];

  Cocktail({
    required this.name,
    required this.imgLink,
    required this.id,
  });

  bool isToBeDisplayed() {
    if (cockf.noAlchool &
        !(this.isAlchool.contains(RegExp('non', caseSensitive: false)))) {
      return false;
    }
    if (cockf.onlyComplete & !this.isComplete) {
      return false;
    }
    return true;
  }

  factory Cocktail.fromJson(dynamic drink) {
    return Cocktail(
      name: drink['strDrink'],
      imgLink: drink['strDrinkThumb'],
      id: drink['idDrink'],
    );
  }
}

Future<List<Cocktail>> fetchCockList(List<String> ingredients) async {
  List<Cocktail> cockList = [];
  Cocktail cock;
  for (var ingredient in ingredients) {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
            ingredient));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map decoded = jsonDecode(response.body);
      for (dynamic drink in decoded['drinks']) {
        cock = Cocktail.fromJson(drink);
        fetchCockDetail(cock, ingredients).then(
            (val) => isInCockList(val, cockList) ? null : cockList.add(val));
      }
      for (cock in cockList) {
        if (cock.missing.isEmpty) {
          cock.isComplete = true;
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load Cocktail list from https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
              ingredient);
    }
  }
  return cockList;
}

Future<Cocktail> fetchCockDetail(
    Cocktail cocktail, List<String> ingredients) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' +
          cocktail.id));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    String ing = "";
    cocktail.isAlchool = decoded['drinks'][0]['strAlcoholic'];
    cocktail.prefGlass = decoded['drinks'][0]['strGlass'];
    cocktail.instructions = decoded['drinks'][0]['strInstructions'];
    // 16 because of hardcoded number of ingredients
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
    return cocktail;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Cocktail list from https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' +
            cocktail.id);
  }
}

bool isInCockList(Cocktail val, List<Cocktail> cockList) {
  for (Cocktail cock in cockList) {
    if (val.name == cock.name) {
      return true;
    }
  }
  return false;
}
