import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/repository/task_repository_provider.dart';
import 'package:todolist/provider/task/task.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
