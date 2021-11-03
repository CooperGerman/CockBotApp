import 'dart:convert';
import 'package:cockbotapp/cock.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postCock(Cocktail cock) {
  String add = "";
  if ((defaultTargetPlatform == TargetPlatform.windows) |
      (defaultTargetPlatform == TargetPlatform.macOS) |
      (defaultTargetPlatform == TargetPlatform.linux)) {
    add = "http://cockbotserver.local:8001/";
  }
  if ((defaultTargetPlatform == TargetPlatform.iOS) |
      (defaultTargetPlatform == TargetPlatform.android) |
      (defaultTargetPlatform == TargetPlatform.fuchsia)) {
    add = "http://cockbotserver.local:8001/";
  }
  return http.post(
    Uri.parse(add),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      cock.name: {
        'imgLink': cock.imgLink,
        'id': cock.id,
        'tag': cock.tag,
        'isAlchool': cock.isAlchool,
        'prefGlass': cock.prefGlass,
        'instructions': cock.instructions,
        'ingredients': cock.ingredients,
        'measures': cock.measures
      },
    }),
  );
}
