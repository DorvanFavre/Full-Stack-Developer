import 'package:flutter/material.dart';

class BreathAnimation extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;
  final Offset offset;

  BreathAnimation(
      {@required this.child,
      this.scale = 1.2,
      this.offset = const Offset(0, 10),
      this.duration = const Duration(milliseconds: 2000)})
      : assert(child != null);
  @override
  _BreathAnimationState createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _scaleAnimation;
  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _scaleAnimation = Tween<double>(begin: 1, end: widget.scale).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController));

    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: widget.offset)
        .animate(CurvedAnimation(
            curve: Curves.easeInOut, parent: _animationController));

    _animationController.repeat(reverse: true);
    //_animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
