import 'package:stubbo_ui/router.dart';

import 'di/injection.dart';

mixin NavigationMixin {
  final NavigationRouter router = injector.get<NavigationRouter>();
}