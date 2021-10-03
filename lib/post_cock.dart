import 'dart:convert';
import 'package:cockbotapp/cock.dart';

import 'package:http/http.dart' as http;

Future<http.Response> postCock(Cocktail cock) {
  return http.post(
    Uri.parse('http://10.0.2.2:8001/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Cock': cock.name,
    }),
  );
}
