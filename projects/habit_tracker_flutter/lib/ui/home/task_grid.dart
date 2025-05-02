import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

class TaskGrid extends StatelessWidget {
  const TaskGrid({super.key, required this.tasks});
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskWithName(task: task);
      },
      itemCount: tasks.length,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
