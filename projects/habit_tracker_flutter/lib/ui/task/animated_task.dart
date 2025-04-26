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
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedBuilder(
          animation: _animatedController,
          builder: (context, child) {
            return TaskCompletionRing(progress: _animatedController.value);
          }),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.forward();
    } else {
      _animatedController.value = 0.0;
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.reverse();
    }
  }
}
