import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/config/config.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/provider/date_provider.dart';
import 'package:todolist/provider/task/task.dart';
import 'package:todolist/utils/utils.dart';
import 'package:todolist/widget/main_drawer.dart';
import 'package:todolist/widget/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final unCompletedTask = _unCompletedTask(taskState.tasks, ref);
    final completedTask = _completedTask(taskState.tasks, ref);

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayText(
                      text: "Nov 27, 2023",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    Gap(20),
                    DisplayText(
                      text: "My Todo App",
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DisplayTask(
                    tasks: unCompletedTask,
                  ),
                  Text(
                    'Completed',
                    style: context.textTheme.headlineMedium,
                  ),
                  const Gap(20),
                  DisplayTask(
                    tasks: completedTask,
                    isCompletedTasks: true,
                  ),
                  const Gap(20),
                  ElevatedButton(
                      onPressed: () =>
                          context.push(RouteLocation.createTaskScreen),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayText(
                          text: "Add New Task",
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

   void _setScreen(String identifier) async {
    if (identifier == 'main') {
    } else if (identifier == 'logout') {
      logout();
    }
  }

  void logout() async {
  try {
    await FirebaseAuth.instance.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    final facebookLogin = FacebookAuth.instance;
    await facebookLogin.logOut();
  } catch (e) {
    print("Error during logout: $e");
  }
}


  List<Task> _unCompletedTask(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> filteredTask = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }

  List<Task> _completedTask(List<Task> tasks, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final List<Task> filteredTask = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        final isTaskDay = Helpers.isTaskFromSelectedDate(task, date);
        if (isTaskDay) {
          filteredTask.add(task);
        }
      }
    }
    return filteredTask;
  }
}
