import 'package:hive/hive.dart';

import '../data/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox('tasks');

    // await _tasks.clear();
    // await _tasks.add(Task('1', 'Buy a chocolate plate', false));
    // await _tasks.add(Task('2', 'Throw out the trash', true));
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((value) => value.user == username);

    return tasks.toList();
  }

  void addTask(String task, String username) {
    _tasks.add(Task(username, task, false));
  }

  Future<void> deleteTask(String task, String username) async {
    final taskToDelete = _tasks.values
        .firstWhere((value) => value.task == task && value.user == username);
    await taskToDelete.delete();
  }

  Future<void> updateTask(final String task, final String username) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final index = taskToEdit.key as int;
    await _tasks.put(index, Task(username, task, !taskToEdit.completed));
  }
}
