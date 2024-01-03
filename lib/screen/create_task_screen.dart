import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/config/config.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/provider/provider.dart';
import 'package:todolist/utils/app_alert.dart';
import 'package:todolist/utils/notification_util.dart';
import 'package:todolist/widget/widgets.dart';
import 'package:todolist/utils/utils.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const DisplayText(
          text: 'Add New Task',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommenTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              const Gap(30),
              const SelectCategory(),
              const Gap(30),
              const SelectDateTime(),
              const Gap(30),
              CommenTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLine: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: _createTask,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayText(
                    text: 'Save',
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.read(dateProvider);
    final time = ref.read(timeProvider);
    final category = ref.read(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMMd().format(date),
        category: category,
        isCompleted: false,
      );

      try {
        await ref.read(taskProvider.notifier).createTask(task);
        AppAlert.displaySnacBar(context, "Task Created Successfully");
        
      // Tambahkan pemanggilan untuk menjadwalkan notifikasi
      await NotificationUtils.scheduleNotification(
        DateTime.parse(task.date + ' ' + task.time),
        'Task Reminder',
        'Don\'t forget to complete your task: $title',
      );
        context.go(RouteLocation.home);
      } catch (e) {
        AppAlert.displaySnacBar(context, "Failed to create task: $e");
      }
    } else {
      AppAlert.displaySnacBar(context, "Task title cannot be empty");
    }
  }
}
