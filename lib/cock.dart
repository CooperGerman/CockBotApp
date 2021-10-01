import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cocktail {
  final String name;
  final String imgLink;
  final String id;
  String isAlchool = '';
  List<String> ingredients = [];

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

List<Cocktail> cockList = [];
Future<List<Cocktail>> fetchCockList(String ingredient) async {
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

    return cockList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Cocktail list from https://www.thecocktaildb.com');
  }
}

Future<void> fetchCockDetail(Cocktail cocktail) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' +
          cocktail.id));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    cocktail.isAlchool = decoded['drinks'][0]['strAlcoholic'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
        'Failed to load Cocktail list from https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=' +
            cocktail.id);
  }
}
