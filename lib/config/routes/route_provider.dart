import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/config/config.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: appRoutes,
    navigatorKey: navigationKey,
    initialLocation: RouteLocation.home,
  );
});
