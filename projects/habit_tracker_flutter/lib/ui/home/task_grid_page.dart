import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/task_grid.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskGridPage extends StatelessWidget {
  const TaskGridPage({super.key, required this.tasks});
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(child: TaskGridContents(tasks: tasks)),
    );
  }
}

class TaskGridContents extends StatelessWidget {
  const TaskGridContents({super.key, required this.tasks});
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: TaskGrid(
          tasks: tasks,
        ));
  }
}
