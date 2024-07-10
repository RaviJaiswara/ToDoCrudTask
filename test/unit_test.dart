import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_task_app/data/models/task.dart';

void main() {
  final task = Task(name: 'Test', status: 'P');

  test("Test task model", () {
    expect(task.name, 'Test');
  });
}
