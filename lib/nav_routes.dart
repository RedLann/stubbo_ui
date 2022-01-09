import 'package:flutter/material.dart';

import 'editor/editor_page.dart';
import 'home/home_page.dart';

class Routes {
  Routes._();

  static const String home = "/home";
  static const String editor = "/editor/";
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static Map<String, Widget Function(dynamic context, String match)> paths = {
    Routes.home: (_, __) => HomePage(),
    Routes.editor: (context, match) => EditorPage(filename: match)
  };

  static getHomePage(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (context) => paths[Routes.home]!(context, ""),
      settings: settings,
    );
  }

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final path = settings.name;
    if (path == null) {
      return null;
    } else if (settings.name == Routes.home) {
      return getHomePage(settings);
    } else {
      for (String key in paths.keys) {
        if (path.startsWith(key)) {
          final builder = paths[key];
          if (builder != null) {
            return MaterialPageRoute<void>(
              builder: (context) => builder(context, path.replaceFirst(key, "")),
              settings: settings,
            );
          }
        }
      }
    }
    return null;
  }
}

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;
}