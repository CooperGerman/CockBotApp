import 'package:cockbotapp/cockHiveDb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout_manager.dart';
import 'detail_viewer.dart';
import 'liquid_viewer.dart';
import 'pour_progress.dart';
import 'cock_filters.dart';
import 'random_cock.dart';
import 'wip.dart';
import 'home.dart';

const String homeRoute = '/';

const String layout_manager = '/layout_manager';
const String detail_viewer = '/detail_viewer';
const String liquid_viewer = '/liquid_viewer';
const String pour_progress = '/pour_progress';
const String cock_filters = '/cock_filters';
const String rand_cock = '/rand_cock';
const String work_in_progress = '/work_in_progress';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  homeRoute: (BuildContext context) => Home(),
  layout_manager: (BuildContext context) => LayoutManager(),
  detail_viewer: (BuildContext context) => DetailViewer(),
  liquid_viewer: (BuildContext context) => LiquidViewer(),
  pour_progress: (BuildContext context) => PourProgress(),
  cock_filters: (BuildContext context) => CockFilters(),
  rand_cock: (BuildContext context) => RandomCock(),
  work_in_progress: (BuildContext context) => WorkInProgress(),
};
