import 'package:flutter/widgets.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask(
      {super.key,
      required this.iconName,
      required this.completed,
      this.onCompleted});
  final String iconName;
  final bool completed;
  final ValueChanged<bool>? onCompleted;

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;
  late final Animation<double> _curveAnimation;
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _curveAnimation =
        _animatedController.drive(CurveTween(curve: Curves.easeInOut));
    _animatedController.addStatusListener(_checkStatusUpdates);
  }

  @override
  void dispose() {
    _animatedController.removeStatusListener(_checkStatusUpdates);
    _animatedController.dispose();
    super.dispose();
  }

  void _checkStatusUpdates(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call(true);
      if (mounted) {
        setState(() => _showCheckIcon = true);
      }
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() => _showCheckIcon = false);
        }
      });
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.completed &&
        _animatedController.status != AnimationStatus.completed) {
      _animatedController.forward();
    } else if (!_showCheckIcon) {
      widget.onCompleted?.call(false);
      _animatedController.value = 0.0;
    }
  }

  void _handleTapCancel() {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: (_) => _handleTapCancel(),
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
          animation: _curveAnimation,
          builder: (context, child) {
            final themeData = AppTheme.of(context);
            final progress = widget.completed ? 1.0 : _curveAnimation.value;
            final hasCompleted = progress == 1.0;
            final iconColor =
                hasCompleted ? themeData.accentNegative : themeData.taskIcon;

            return Stack(
              children: [
                TaskCompletionRing(progress: _curveAnimation.value),
                Positioned.fill(
                  child: CenteredSvgIcon(
                      iconName: hasCompleted && _showCheckIcon
                          ? AppAssets.check
                          : widget.iconName,
                      color: iconColor),
                )
              ],
            );
          }),
    );
  }
}
