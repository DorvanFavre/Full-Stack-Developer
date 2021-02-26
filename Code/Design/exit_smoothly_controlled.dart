import 'package:flutter/material.dart';

/// Créer par D0rvan
/// 12.01.2021
///
///
class ExiteSmoothlyControlled extends StatelessWidget {
  /// Widget to animate
  final Widget child;
  final AnimationController animationController;

  // from where the widget comes
  final Offset slideToOffset;

  /// Slide animation
  ///
  /// Wrap a widget to make it enter smoothly when its build
  ///
  ///
  ExiteSmoothlyControlled({
    @required this.child,
    @required this.animationController,
    this.slideToOffset = const Offset(-30, 0),
  }) {
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic));
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: slideToOffset)
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.easeInOutCubic));
  }

  Animation _opacityAnimation;
  Animation _slideAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, a) {
          return Transform.translate(
            offset: _slideAnimation.value,
            child: Opacity(opacity: _opacityAnimation.value, child: a),
          );
        },child: child,);
        
  }
}
