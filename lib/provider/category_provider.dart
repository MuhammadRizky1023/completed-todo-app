import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/utils/utils.dart';

final categoryProvider = StateProvider<TaskCategories>((ref) {
  return TaskCategories.other;
});
