import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:to_do_task_app/domain/usecases/get_task_usecases.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_event.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTaskUsecases? getTaskUsecases;

  TaskBloc({this.getTaskUsecases}) : super(TaskInitialState()) {
    on<GetTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      final data = await getTaskUsecases!();
      emit(TaskLoadedState(data));
    });
  }
}
