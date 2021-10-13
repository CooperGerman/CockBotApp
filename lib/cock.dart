import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:http/http.dart' as http;

class Cocktail {
  final String name;
  final String imgLink;
  final String id;
  String isAlchool = '';
  String prefGlass = '';
  String instructions = '';
  List<String> ingredients = [];
  List<String> measures = [];

  Cocktail({
    required this.name,
    required this.imgLink,
    required this.id,
  });

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
  for (var ingredient in ingredients) {
    print('Searching cocktail with ingrtedient ' + ingredient);
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=' +
            ingredient));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map decoded = jsonDecode(response.body);
      for (dynamic drink in decoded['drinks']) {
        cockList.add(Cocktail.fromJson(drink));
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

Future<Cocktail> fetchCockDetail(Cocktail cocktail) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' +
          cocktail.id));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    cocktail.isAlchool = decoded['drinks'][0]['strAlcoholic'];
    cocktail.prefGlass = decoded['drinks'][0]['strGlass'];
    cocktail.instructions = decoded['drinks'][0]['strInstructions'];
    for (var i = 1; i < 16; i++) {
      if (decoded['drinks'][0]['strIngredient' + i.toString()] != null) {
        cocktail.ingredients
            .add(decoded['drinks'][0]['strIngredient' + i.toString()]);
        // } else {
        //   cocktail.ingredients.add('null');
      }
      if (decoded['drinks'][0]['strMeasure' + i.toString()] != null) {
        cocktail.measures
            .add(decoded['drinks'][0]['strMeasure' + i.toString()]);
        // } else {
        //   cocktail.measures.add('null');
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
