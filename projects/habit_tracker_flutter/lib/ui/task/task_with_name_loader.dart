import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

class TaskWithNameLoader extends ConsumerWidget {
  const TaskWithNameLoader({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskStateListenable(task: task),
      builder: (context, box, child) {
        final taskstate = dataStore.taskstate(box, task: task);
        return TaskWithName(
          task: task,
          completed: taskstate.completed,
          onCompleted: (completed) {
            dataStore.setTaskState(task: task, completed: completed);
          },
        );
      },
    );
  }
}
