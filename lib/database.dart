import 'package:cockbotapp/physical.dart';

import 'cock.dart';
import 'package:firebase_database/firebase_database.dart';

import 'cock_filters.dart';

List liqList = [];

Future<void> initDB() async {
  liqList = await fetchLiquidsList();
}

Future<void> updateDB() async {
  // Initialize Firebase
  FirebaseDatabase _database = FirebaseDatabase.instance;

  // Wait for fetchLiquidList to complete
  CockList cockList = CockList();
  await fetchLiquidsList().then((val1) async {
    cockList = await fetchCockList(val1);
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
          // print('Updating field ' + cocktail.name);
          await _database.ref('cocktails').child(key).update(cocktail.toMap());
        } else {
          // Cocktail already exists, skip adding it
          // print('Field ' +
          // key +
          // 'of' +
          // cocktail.name +
          // ' is unchanged, skipping');
        }
      }
    }
  }
}

Future<List<Cocktail>> applyFilters() async {
  // Retrieve all the cocktails from the Firebase database
  final cocktailsSnapshot = await FirebaseDatabase.instance
      .ref('cocktails')
      .once(DatabaseEventType.value);
  final cocktailsMap = cocktailsSnapshot.snapshot.value as Map<String, dynamic>;

  // Convert the retrieved cocktails into a list of Cocktail objects
  List<Cocktail> cocktails = [];
  cocktailsMap.forEach((key, value) {
    cocktails.add(Cocktail.fromMap(value));
  });
  // Filter the list of cocktails based on the values set in the CockFilterValues object
  if (cockFiltVals.onlyComplete) {
    cocktails += cocktails.where((cocktail) => cocktail.isComplete).toList();
  }
  if (!cockFiltVals.noAlchool) {
    cocktails += cocktails
        .where((cocktail) =>
            cocktail.isAlcohol.contains(RegExp('non', caseSensitive: false)))
        .toList();
  }
  if (cockFiltVals.allowMissingNonLiquids) {
    cocktails += cocktails.where((cocktail) => cocktail.isComplete).toList();
  }
  if (cockFiltVals.containsLiquid) {
    cocktails += cocktails
        .where((cocktail) =>
            liqList.any((element) => cocktail.ingredients.contains(element)))
        .toList();
  }

  if (!cockFiltVals.all) {
    List<Cocktail> tempCocktails = [];
    for (String category in cockFiltVals.categories.keys) {
      if (cockFiltVals.categories[category]) {
        tempCocktails.addAll(cocktails
            .where((cocktail) => cocktail.category == category)
            .toList());
      }
    }
    cocktails += tempCocktails;
  }

  // Return the filtered list of cocktails
  return cocktails;
}
