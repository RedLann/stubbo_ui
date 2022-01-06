import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stubbo_ui/data/local_datasource.dart';
import 'package:stubbo_ui/data/repository.dart';

final GetIt injector = GetIt.instance;

Future<void> initDi() async {
  injector.registerSingleton(GlobalKey<NavigatorState>());
  final ld = LocalDatasource();
  await ld.openBox();
  injector.registerSingleton(ld);
  injector.registerFactory(() => Repository());
}

Future<void> initDevEnv() async {

}

