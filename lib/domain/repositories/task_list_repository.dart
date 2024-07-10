import 'package:to_do_task_app/domain/entities/task_entity.dart';

abstract class TaskListRepository {
  Future<TaskEntity> getTask();
}
