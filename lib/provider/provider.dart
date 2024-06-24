import 'package:flutter/material.dart';
import 'package:my_tasks/models/task.dart';
import 'package:my_tasks/utils/globals.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> tasks = [
    Task(
        id: 1,
        title: 'Task 1',
        description: 'Description 1',
        isComplete: false,
        priority: Priority.SIMPLE),
    Task(
        id: 2,
        title: 'Task 2',
        description: 'Description 2',
        isComplete: false,
        priority: Priority.MEDIUM),
    Task(
        id: 3,
        title: 'Task 3',
        description: 'Description 3',
        isComplete: false,
        priority: Priority.DIFFICULT),
  ];

  void add(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void remove(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void update(Task task) {
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;
    notifyListeners();
  }
}
