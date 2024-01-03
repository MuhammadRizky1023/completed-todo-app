import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/config/routes/routes.dart';
import 'package:todolist/screen/create_task_screen.dart';
import 'package:todolist/screen/edit_task_screen.dart';
import 'package:todolist/screen/home_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTaskScreen,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.editTaskScreen,
    parentNavigatorKey: navigationKey,
    builder: EditTaskScreen.builder,
  )
];
