import 'package:habit_tracker_flutter/models/task.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const taskBoxName = 'tasks';
  Future<void> init() async {
    await Hive.initFlutter();

    // Register the adapter for the Task model
    Hive.registerAdapter<Task>(TaskAdapter());

    // Open the box for storing tasks
    await Hive.openBox<Task>(taskBoxName);
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
}
