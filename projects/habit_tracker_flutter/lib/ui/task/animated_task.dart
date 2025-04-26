import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  final String iconName;
  const AnimatedTask({super.key, required this.iconName});

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;
  late final Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _curveAnimation =
        _animatedController.drive(CurveTween(curve: Curves.easeInOut));
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
          animation: _curveAnimation,
          builder: (context, child) {
            final themeData = AppTheme.of(context);
            return Stack(
              children: [
                TaskCompletionRing(progress: _curveAnimation.value),
                Positioned.fill(
                  child: CenteredSvgIcon(
                      iconName: widget.iconName, color: themeData.taskIcon),
                )
              ],
            );
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
