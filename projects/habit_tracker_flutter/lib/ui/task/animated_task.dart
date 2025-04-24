import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({super.key});

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TaskCompletionRing(progress: 0.6);
  }
}
