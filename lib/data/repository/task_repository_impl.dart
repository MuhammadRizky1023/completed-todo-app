import 'package:todolist/data/data.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _datasource;

  TaskRepositoryImpl(this._datasource);

  Future<void> linkFirebaseUserWithSqlite(
      String firebaseUserId, Task task) async {
    // Implementasi metode sesuai kebutuhan
    // Menyimpan ID pengguna Firebase ke dalam model Task
    final updatedTask = task.copyWith(userId: firebaseUserId);

    // Menyimpan model Task ke dalam SQLite
    await _datasource.addTask(updatedTask);
  }

  @override
  Future<void> createTask(Task task) async {
    try {
      print('Creating task: $task');
      await _datasource.addTask(task);
      print('Task created successfully');
    } catch (e) {
      print('Failed to create task: $e');
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      await _datasource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Task>> getAllTask() async {
    try {
      return await _datasource.getAllTasks();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      await _datasource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }
}
