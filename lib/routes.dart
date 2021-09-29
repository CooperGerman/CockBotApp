import 'package:flutter/material.dart';

import 'layout_manager.dart';
import 'home.dart';

const String homeRoute = '/';

const String layout_manager = '/layout_manager';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  homeRoute: (BuildContext context) => Home(),
  layout_manager: (BuildContext context) => LayoutManager(),
};
