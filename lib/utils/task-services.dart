import 'package:todolist/data/data.dart';

class TaskService {
  static final TaskService _instance = TaskService._();
  factory TaskService() => _instance;

  TaskService._();

  static final TaskDataSource _dataSource = TaskDataSource();

  Future<List<Task>> fetchAllTasks() async {
    try {
      return await _dataSource.getAllTasks();
    } catch (e) {
      // Handle errors during data fetching
      throw Exception("Failed to fetch tasks: $e");
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _dataSource.updateTask(updatedTask);
    } catch (e) {
      // Handle errors during data update
      throw Exception("Failed to update task: $e");
    }
  }
}
