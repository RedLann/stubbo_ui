import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'di/injection.dart';

class NavigationRouter {
  @protected
  bool isLoaderShown = false;

  final GlobalKey<NavigatorState> navigatorKey = injector.get<GlobalKey<NavigatorState>>();

  NavigationRouter();

  Future<T?> pushOverlay<T>(
    Widget child, {
    bool barrierDismissible = false,
    Color? barrierColor,
  }) async {
    return await showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => child,
    );
  }

  void pushLoader(Widget child) {
    if (!isLoaderShown) {
      isLoaderShown = true;
      pushOverlay(
        WillPopScope(
          onWillPop: () async => false,
          child: child,
        ),
      );
    }
  }

  void popLoader() {
    if (isLoaderShown) {
      isLoaderShown = false;
      navigatorKey.currentState!.pop();
    }
  }

  Future<T?> pushNamed<T>(String route, [Object? arguments]) async {
    return await navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  }

  void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }

  Future<T?> pushAndReplaceNamed<T, TO>(String route, [Object? arguments]) async {
    return await navigatorKey.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  void popUntil<T>(String destination, [T? result]) {
    return navigatorKey.currentState!.popUntil((route) => route.settings.name == destination);
  }

  Future<T?> popAndPushNamed<T, TO>(String route, [Object? arguments]) async {
    return await navigatorKey.currentState!.popAndPushNamed(route, arguments: arguments);
  }

  Future<dynamic> temporizedAlert({
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color? background,
    EdgeInsetsGeometry padding = const EdgeInsets.all(10.0),
  }) {
    return showMessageRevealDialog(
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          child: Padding(
            padding: padding,
            child: Text(
              message,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
      duration: duration,
      barrierColor: Colors.blueGrey.withOpacity(0.5),
    );
  }

  Future<dynamic> showMessageRevealDialog({
    required Widget child,
    Duration? duration,
    Color barrierColor = Colors.transparent,
  }) {
    return showGeneralDialog<String?>(
      barrierDismissible: false,
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
      context: navigatorKey.currentState!.context,
      useRootNavigator: true,
      pageBuilder: (context, anim1, anim2) {
        if (duration != null) {
          Future.delayed(duration).then((value) => pop());
        }
        return Padding(
          padding: const EdgeInsets.all(100.0),
          child: Center(child: child),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return CircularRevealAnimation(
          child: child,
          animation: anim1,
          centerAlignment: Alignment.center,
        );
      },
    );
  }
}
