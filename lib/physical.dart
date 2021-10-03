import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchLiquidsList() async {
  List<String> liquidList = [];
  final response = await http.get(Uri.parse('http://10.0.2.2:8001/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    for (String liquid in decoded.keys) {
      liquidList.add(liquid);
    }

    return liquidList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Cocktail list from http://10.0.2.2:8001/');
  }
}
