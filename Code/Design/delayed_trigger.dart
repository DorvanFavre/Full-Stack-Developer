import 'package:flutter/material.dart';

/// Created by D0rvan
/// 12.01.2021
/// v 1.0
///
///
class DelayedTrigger extends StatelessWidget {
  /// widget that will be built after the delay
  final Widget Function(bool trigger) builder;

  /// The duration befor the child is built
  final Duration delay;

  /// DelayedTrigger
  ///
  /// 1. Build the child with trigger true, 2. wait delay, 3. Rebuild the child with the trigger true
  /// 
  /// To Use with implicite animation (AnimatedContainer)
  ///
  DelayedTrigger(
      {@required this.builder, this.delay = const Duration(seconds: 0)})
      : assert(builder != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return builder(true);
        } else
          return builder(false);
      },
    );
  }
}
