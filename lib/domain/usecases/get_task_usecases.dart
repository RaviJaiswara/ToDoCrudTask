import 'package:to_do_task_app/domain/entities/task_entity.dart';
import 'package:to_do_task_app/domain/repositories/task_list_repository.dart';

class GetTaskUsecases {
  final TaskListRepository taskListRepository;

  GetTaskUsecases(this.taskListRepository);

  Future<TaskEntity> call() async {
    return await taskListRepository.getTask();
  }
}
