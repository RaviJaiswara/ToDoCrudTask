import 'package:get_it/get_it.dart';
import 'package:to_do_task_app/data/datasources/remote/task_list_data_source_impl.dart';
import 'package:to_do_task_app/data/datasources/task_list_data_source.dart';
import 'package:to_do_task_app/data/repositories/task_list_repository_impl.dart';
import 'package:to_do_task_app/domain/repositories/task_list_repository.dart';
import 'package:to_do_task_app/domain/usecases/get_task_usecases.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_bloc.dart';

final getId = GetIt.instance;
void init() {
  getId.registerFactory(() => TaskBloc(getTaskUsecases: getId()));

  getId.registerLazySingleton(() => GetTaskUsecases(getId()));

  getId.registerLazySingleton<TaskListRepository>(
      () => TaskListRepositoryImpl(taskListRemoteDataSource: getId()));

  getId.registerLazySingleton<TaskListRemoteDataSource>(
      () => TaskListDataSourceImpl());
}
