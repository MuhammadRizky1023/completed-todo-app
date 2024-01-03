import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/config/config.dart';
import 'package:todolist/data/model/task.dart';
import 'package:todolist/utils/utils.dart';
import 'package:todolist/widget/widgets.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.task, this.onCompleted});

  final Task task;
  final Function(bool?)? onCompleted;
  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    final backgroundOpacity = task.isCompleted ? 0.3 : 0.5;
    final textDecoration =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              children: [
                CircleContainer(
                  color: task.category.color.withOpacity(backgroundOpacity),
                  child: Center(
                    child: Icon(
                      task.category.icon,
                      color: task.category.color.withOpacity(iconOpacity),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: style.titleMedium?.copyWith(
                      decoration: textDecoration,
                      fontSize: 20,
                      fontWeight: fontWeight),
                ),
                Text(
                  task.time,
                  style: style.titleMedium?.copyWith(
                    decoration: textDecoration,
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () => context.push(RouteLocation.editTaskScreen),
              icon: const Icon(Icons.edit)),
          Checkbox(value: task.isCompleted, onChanged: onCompleted)
        ],
      ),
    );
  }
}
