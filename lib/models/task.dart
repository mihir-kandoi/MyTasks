import 'package:my_tasks/utils/globals.dart';

class Task {
  int id;
  String title;
  String description;
  bool isComplete;
  Priority priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
    required this.priority,
  });
}