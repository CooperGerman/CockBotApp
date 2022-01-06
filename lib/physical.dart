import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

final CockMachine cockMach = CockMachine();

class CockMachine {
  String add = "http://cockbotserver.local:8001/";
  bool isOnline = false;
  List<String> liquids = [];
}

Future<List<String>> fetchLiquidsList() async {
  try {
    final response =
        await Dio().get(cockMach.add).timeout(Duration(seconds: 10));
    Map decoded = jsonDecode(response.data);
    for (String liquid in decoded.keys) {
      cockMach.liquids.add(liquid);
      cockMach.isOnline = true;
    }
  } on DioError catch (e) {
    cockMach.isOnline = false;
    if (e.response == null) {
      print(cockMach.add + " not reachable");
    } else if (e.type == "response") {
      print(cockMach.add + " responded incorrect status");
    } else if (e.type == "cancel") {
      print(cockMach.add + " cancelled");
    } else if (e.type == "connectTimeout") {
      print(cockMach.add + " connection timed out");
    } else if (e.type == "cancel") {
      print(cockMach.add + " cancelled");
    }
    cockMach.liquids = ['*'];
  }
  // final response = await http.get(Uri.parse(add), headers: {
  //   "Access-Control-Allow-Origin": "*",
  //   "Content-type": "text/json"
  // });
  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load Cocktail list from ' + add);
  // }
  return cockMach.liquids;
}

Future<Map> fetchPouringStatus() async {
  String add = cockMach.add + "/PouringStatus/";

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
