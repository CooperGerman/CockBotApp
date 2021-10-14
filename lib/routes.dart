import 'package:flutter/material.dart';

import 'layout_manager.dart';
import 'detail_viewer.dart';
import 'liquid_viewer.dart';
import 'pour_progress.dart';
import 'home.dart';

const String homeRoute = '/';

const String layout_manager = '/layout_manager';
const String detail_viewer = '/detail_viewer';
const String liquid_viewer = '/liquid_viewer';
const String pour_progress = '/pour_progress';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  homeRoute: (BuildContext context) => Home(),
  layout_manager: (BuildContext context) => LayoutManager(),
  detail_viewer: (BuildContext context) => DetailViewer(),
  liquid_viewer: (BuildContext context) => LiquidViewer(),
  pour_progress: (BuildContext context) => PourProgress(),
};
