import 'package:to_do_task_app/domain/entities/task_entity.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final TaskEntity taskEntity;

  TaskLoadedState(this.taskEntity);
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState(this.error);
}
