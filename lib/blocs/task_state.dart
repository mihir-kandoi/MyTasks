part of 'task_bloc.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {}

final class TaskAdded extends TaskState {
  final Task task;

  const TaskAdded(this.task);
}

final class TaskDeleted extends TaskState {
  final Task task;

  const TaskDeleted(this.task);
}

final class TaskUpdated extends TaskState {
  final Task task;

  const TaskUpdated(this.task);
}

final class TaskCleared extends TaskState {}