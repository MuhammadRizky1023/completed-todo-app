import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/data.dart';

final taskDatasourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSource();
});
