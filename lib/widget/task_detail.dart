import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/utils/utils.dart';
import 'package:todolist/widget/widgets.dart';

class TaskDetail extends StatelessWidget {
  const TaskDetail({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Center(
              child: Icon(
                task.category.icon,
                color: task.category.color,
              ),
            ),
          ),
          const Gap(20),
          Text(
            task.title,
            style: style.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(task.time, style: style.titleMedium),
          const Gap(20),
          Visibility(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("task to be complated on ${task.date}"),
              Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ],
          )),
          const Gap(20),
          Divider(
            thickness: 1.5,
            color: task.category.color,
          ),
          const Gap(20),
          Text(task.note.isEmpty ? "There is no note for this task" : task.note)
        ],
      ),
    );
  }
}
