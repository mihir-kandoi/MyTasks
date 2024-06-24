part of 'task_bloc.dart';

sealed class TaskEvent {
  const TaskEvent();
}

final class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent(this.task);
}

final class RemoveTaskEvent extends TaskEvent {
  final Task task;

  const RemoveTaskEvent(this.task);
}

final class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);
}

final class ClearTasksEvent extends TaskEvent {}