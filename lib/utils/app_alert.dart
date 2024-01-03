import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/provider/provider.dart';
import 'package:todolist/utils/utils.dart';

class AppAlert {
  AppAlert._();

  static displaySnacBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.surface,
        ),
      ),
      backgroundColor: context.colorScheme.primary,
    ));
  }

  static Future<void> showDeletedAlertDialog(
      BuildContext context, WidgetRef ref, Task task) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('No'),
    );
    Widget deletedButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then((value) => {
              AppAlert.displaySnacBar(context, 'Task deleted successfully'),
              context.pop()
            });
      },
      child: const Text('Yes'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text('Are you sure you want to delete this task?'),
      actions: [deletedButton, cancelButton],
    );
    await showDialog(
        context: context,
        builder: (ctx) {
          return alert;
        });
  }
}
