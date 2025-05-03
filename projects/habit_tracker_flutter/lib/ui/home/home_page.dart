import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskListenable(),
      builder: (_, box, __) => TaskGridPage(tasks: box.values.toList()),
    );
  }
}
