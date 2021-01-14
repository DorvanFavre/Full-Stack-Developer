import 'package:flutter/material.dart';

class BreathAnimation extends StatefulWidget {
  final Widget child;

  BreathAnimation({@required this.child}) : assert(child != null);
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

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController));

    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, -10))
        .animate(
            CurvedAnimation(curve: Curves.easeInOut, parent: _animationController));

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
