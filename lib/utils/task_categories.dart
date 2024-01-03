import 'package:flutter/material.dart';

enum TaskCategories {
  education(Icons.school, Colors.blueGrey),
  health(Icons.favorite, Colors.orangeAccent),
  personal(Icons.person, Colors.lightBlue),
  shopping(Icons.shopping_bag, Colors.pink),
  social(Icons.people, Colors.lightBlueAccent),
  travel(Icons.flight, Colors.blue),
  work(Icons.work, Colors.grey),
  other(Icons.school, Colors.purple);

  static TaskCategories stringToTaskCategory(String name) {
    try {
      return TaskCategories.values
          .firstWhere((category) => category.name == name);
    } catch (e) {
      return TaskCategories.other;
    }
  }

  final IconData icon;
  final Color color;
  const TaskCategories(this.icon, this.color);
}
