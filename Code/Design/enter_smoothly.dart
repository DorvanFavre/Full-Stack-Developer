import 'package:flutter/material.dart';

/// Créer par D0rvan
/// 12.01.2021
///
///
class EnterSmoothly extends StatefulWidget {
  /// Widget to animate
  final Widget child;

  /// how long the animation takes
  final Duration duration;

  // after how long the animation starts
  final Duration delay;

  // from where the widget comes
  final Offset slideFromOffset;

  /// Slide animation
  ///
  /// Wrap a widget to make it enter smoothly when its build
  ///
  ///
  EnterSmoothly({
    @required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = const Duration(milliseconds: 0),
    this.slideFromOffset = const Offset(-30, 0),
  });

  @override
  _EnterSmoothlyState createState() => _EnterSmoothlyState();
}

class _EnterSmoothlyState extends State<EnterSmoothly>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  Animation _opacityAnimation;
  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration + widget.delay,
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: Interval(
            widget.delay.inMilliseconds /
                (widget.delay.inMilliseconds + widget.duration.inMilliseconds),
            1.0,
            curve: Curves.ease));

    // Animations
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation);
    _slideAnimation =
        Tween<Offset>(begin: widget.slideFromOffset, end: Offset.zero)
            .animate(_curvedAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _slideAnimation.value,
            child:
                Opacity(opacity: _opacityAnimation.value, child: widget.child),
          );
        });
  }
}
