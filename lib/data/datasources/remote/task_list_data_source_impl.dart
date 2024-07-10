import 'package:to_do_task_app/data/datasources/task_list_data_source.dart';
import 'package:to_do_task_app/data/models/task_model.dart';

class TaskListDataSourceImpl extends TaskListRemoteDataSource {
  @override
  Future<TaskModel> getTask() async {
    String data = '{"taskName":"Playing"}';
    final TaskModel taskModel = taskModelFromJson(data);
    return taskModel;
  }
}
