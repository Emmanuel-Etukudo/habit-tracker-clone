import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  static const taskStateBoxName = 'taskState';

  static String taskStateKey(String taskId) {
    return 'taskState/$taskId';
  }

  Future<void> init() async {
    await Hive.initFlutter();

    // Register the adapter
    Hive.registerAdapter<Task>(TaskAdapter());
    Hive.registerAdapter<TaskState>(TaskStateAdapter());

    // Open the box for storing tasks
    await Hive.openBox<Task>(taskBoxName);
    await Hive.openBox<TaskState>(taskStateBoxName);
  }

  Future<void> createDemoTasks(
      {required List<Task> tasks, bool force = false}) async {
    final box = Hive.box<Task>(taskBoxName);
    if (box.isEmpty || force) {
      await box.clear(); // Clear the box if it's not empty or force is true
      await box.addAll(tasks);
    } else {
      print(
          'Box is not empty, skipping demo task creation. box length: ${box.length}');
    }
  }

  ValueListenable<Box<Task>> taskListenable() {
    return Hive.box<Task>(taskBoxName).listenable();
  }

  Future<void> setTaskState({
    required Task task,
    required String completed,
  }) async {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final taskState = TaskState(taskId: task.id, completed: completed);
    await box.put(taskStateKey(task.id), taskState);
  }

  ValueListenable<Box<TaskState>> taskStateListenable({required Task task}) {
    final box = Hive.box<TaskState>(taskStateBoxName);
    final key = taskStateKey(task.id);
    return box.listenable(keys: [key]);
  }
}

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});
