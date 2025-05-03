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
}
