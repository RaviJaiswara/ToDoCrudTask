import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task_app/core/locators/dependency_injectors.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_bloc.dart';
import 'package:to_do_task_app/presentation/views/task/task_list_view.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.title,
    this.message,
  });

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskBloc(getTaskUsecases: getId()),
          ),
        ],
        child: MaterialApp(
          title: 'Task List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: TaskListView(),
        ));
  }
}
