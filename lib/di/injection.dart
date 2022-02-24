import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stubbo_ui/data/local_datasource.dart';
import 'package:stubbo_ui/data/repository.dart';

import '../router.dart';

final GetIt injector = GetIt.instance;

Future<void> initDi() async {
  injector.registerSingleton(GlobalKey<NavigatorState>());
  injector.registerSingleton(NavigationRouter());
  final ld = LocalDatasource();
  await ld.openBox();
  injector.registerSingleton(ld);
  injector.registerFactory(() => Repository());
  injector.registerSingleton("https://stubbo.eu.ngrok.io/", instanceName: "baseurl");
  injector.registerSingleton(await SharedPreferences.getInstance());
}

Future<void> initDevDi() async {
  injector.registerSingleton(GlobalKey<NavigatorState>());
  injector.registerSingleton(NavigationRouter());
  final ld = LocalDatasource();
  await ld.openBox();
  injector.registerSingleton(ld);
  injector.registerFactory(() => Repository());
  injector.registerSingleton("http://0.0.0.0:8080/", instanceName: "baseurl");
  injector.registerSingleton(await SharedPreferences.getInstance());
}
