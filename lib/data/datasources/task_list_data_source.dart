import 'package:to_do_task_app/data/models/task_model.dart';

abstract class TaskListRemoteDataSource {
  Future<TaskModel> getTask();
}
