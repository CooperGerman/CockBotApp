import 'cock.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CocktailDatabase {
  CockList _cockList = CockList();
  Box<Cocktail> box;
  CocktailDatabase({required this.box});

  Future<void> addCocktail(Cocktail cocktail) async {
    final index = box.add(cocktail);
    print('Cocktail added at index $index');
  }

  Future<void> updateCocktail(int index, Cocktail cocktail) async {
    box.put(index, cocktail);
  }

  Future<void> deleteCocktail(int index) async {
    box.deleteAt(index);
  }

  // Stream<List<Cocktail>> get cocktails => box.watch();

  Future<void> fetchDB() async {
    print('Fetching DB');
    _cockList = await fetchCockList(['*'], _cockList);
    // Iterate over all the cocktails in the CockList
    for (var cocktail in _cockList.elements) {
      // Check if the cocktail is already present in the box
      if (!box.containsKey(cocktail.id)) {
        // If the cocktail is not present, add it to the box
        addCocktail(cocktail);
      }
    }
  }

  List<Cocktail> filterCocktails(String pattern) {
    // Get a list of all the cocktails in the box
    List<Cocktail> cocktails = box.values.toList();

    // Use the where method to filter the list
    return cocktails
        .where((cocktail) => cocktail.name.contains(pattern))
        .toList();
  }

  Cocktail selectRandomCocktail() {
    // Get a list of all the keys in the box
    List<dynamic> keys = box.keys.toList();
    Cocktail ret = Cocktail(name: 'Empty', imgLink: '', id: '');
    // Shuffle the keys
    keys.shuffle();
    // If the shuffled list is not empty, return the first cocktail in the list
    if (keys.isNotEmpty) {
      ret = box.get(keys.first) ?? ret;
    }
    return ret;
  }
}
