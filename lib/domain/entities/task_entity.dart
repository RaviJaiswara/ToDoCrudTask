import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? taskName;

  const TaskEntity({required this.taskName});

  @override
  List<Object?> get props => [taskName];
}
