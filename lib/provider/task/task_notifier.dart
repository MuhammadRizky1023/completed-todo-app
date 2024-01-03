import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/provider/task/task.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getTask();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      getTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updateTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updateTask);
      getTask();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getTask() async {
    try {
      final task = await _repository.getAllTask();
      state = state.copyWith(tasks: task);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
