// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters

import 'dart:convert';

import 'package:to_do_task_app/domain/entities/task_entity.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

class TaskModel extends TaskEntity {
  TaskModel({String? taskName}) : super(taskName: taskName);

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(taskName: json['taskName']);

  TaskEntity toEntity() {
    return TaskEntity(taskName: taskName);
  }
}
