import 'dart:async';
import 'dart:convert';
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
    cockMach.liquids = [];
    for (String liquid in decoded.keys) {
      cockMach.liquids.add(liquid);
      cockMach.isOnline = true;
    }
    print(cockMach.add + " fetched sucessfully");
  } on DioError catch (e) {
    cockMach.isOnline = false;
    if (e.response == null) {
      print(cockMach.add + " not reachable");
    } else if (e.type.toString() == "response") {
      print(cockMach.add + " responded incorrect status");
    } else if (e.type.toString() == "connectTimeout") {
      print(cockMach.add + " connection timed out");
    } else if (e.type.toString() == "cancel") {
      print(cockMach.add + " cancelled");
    }
    cockMach.liquids = ['*'];
  }
  return cockMach.liquids;
}

Future<Map> fetchPouringStatus() async {
  String add = cockMach.add + "PouringStatus/";
  Map decoded = {};
  try {
    final response = await Dio().get(add).timeout(Duration(seconds: 10));
    decoded = jsonDecode(response.data);
    print(add + " fetched sucessfully");
  } on DioError catch (e) {
    cockMach.isOnline = false;
    if (e.response == null) {
      print(add + " not reachable");
    } else if (e.type.toString() == "response") {
      print(add + " responded incorrect status");
    } else if (e.type.toString() == "connectTimeout") {
      print(add + " connection timed out");
    } else if (e.type.toString() == "cancel") {
      print(add + " cancelled");
    }
    cockMach.liquids = ['*'];
  }
  return decoded;
}

Future<Map> cancelPouring() async {
  String add = cockMach.add + "CancelPouring/";
  Map decoded = {};
  try {
    final response = await Dio().get(add).timeout(Duration(seconds: 10));
    // cast response.data to an integer
    decoded = jsonDecode(response.data);
    print(add + " fetched sucessfully");
  } on DioError catch (e) {
    if (e.response == null) {
      print(add + " not reachable");
    } else if (e.type.toString() == "response") {
      print(add + " responded incorrect status");
    } else if (e.type.toString() == "connectTimeout") {
      print(add + " connection timed out");
    } else if (e.type.toString() == "cancel") {
      print(add + " cancelled");
    }
  }
  return decoded;
}
