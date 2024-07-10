import 'package:to_do_task_app/data/datasources/task_list_data_source.dart';
import 'package:to_do_task_app/data/models/task_model.dart';
import 'package:to_do_task_app/domain/entities/task_entity.dart';
import 'package:to_do_task_app/domain/repositories/task_list_repository.dart';

class TaskListRepositoryImpl implements TaskListRepository {
  TaskListRemoteDataSource taskListRemoteDataSource;

  TaskListRepositoryImpl({required this.taskListRemoteDataSource});
  @override
  Future<TaskEntity> getTask() async {
    final TaskModel taskModel = await taskListRemoteDataSource.getTask();
    final TaskEntity taskEntity = taskModel.toEntity();
    return taskEntity;
  }
}
