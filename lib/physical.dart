import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<String>> fetchLiquidsList() async {
  List<String> liquidList = [];
  String add = "";
  if ((defaultTargetPlatform == TargetPlatform.windows) |
      (defaultTargetPlatform == TargetPlatform.macOS) |
      (defaultTargetPlatform == TargetPlatform.linux)) {
    add = "http://localhost:8001/";
  }
  if ((defaultTargetPlatform == TargetPlatform.iOS) |
      (defaultTargetPlatform == TargetPlatform.android) |
      (defaultTargetPlatform == TargetPlatform.fuchsia)) {
    add = "http://10.0.2.2:8001/";
  }

  final response = await http.get(Uri.parse(add), headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-type": "text/json"
  });

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
    throw Exception('Failed to load Cocktail list from ' + add);
  }
}

Future<Map> fetchPouringStatus() async {
  String add = "";
  if ((defaultTargetPlatform == TargetPlatform.windows) |
      (defaultTargetPlatform == TargetPlatform.macOS) |
      (defaultTargetPlatform == TargetPlatform.linux)) {
    add = "http://localhost:8001/PouringStatus/";
  }
  if ((defaultTargetPlatform == TargetPlatform.iOS) |
      (defaultTargetPlatform == TargetPlatform.android) |
      (defaultTargetPlatform == TargetPlatform.fuchsia)) {
    add = "http://10.0.2.2:8001/PouringStatus/";
  }

  final response = await http.get(Uri.parse(add), headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-type": "text/json"
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map decoded = jsonDecode(response.body);
    return decoded;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Cocktail list from ' + add);
  }
}
