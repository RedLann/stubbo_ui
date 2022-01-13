import 'package:flutter/material.dart';
import 'data/local_datasource.dart';
import 'di/injection.dart';
import 'nav_routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  void dispose() {
    injector.get<LocalDatasource>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: injector.get<GlobalKey<NavigatorState>>(),
      title: 'Flutter Demo',
      // routes: routesBuilders,
      initialRoute: Routes.home,
      onUnknownRoute: (RouteSettings settings) =>
          RouteConfiguration.onGenerateRoute(
              settings.copyWith(name: Routes.home)),
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}