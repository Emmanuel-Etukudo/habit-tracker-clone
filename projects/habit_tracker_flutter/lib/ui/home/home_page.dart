import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataStore = HiveDataStore();
    return ValueListenableBuilder(
      valueListenable: dataStore.taskListenable(),
      builder: (_, box, __) => TaskGridPage(tasks: box.values.toList()),
    );
  }
}
