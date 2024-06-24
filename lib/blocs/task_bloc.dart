import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      emit(TaskAdded(event.task));
    });
    on<UpdateTaskEvent>((event, emit) {
      emit(TaskUpdated(event.task));
    });
    on<RemoveTaskEvent>((event, emit) {
      emit(TaskDeleted(event.task));
    });
  }
}
