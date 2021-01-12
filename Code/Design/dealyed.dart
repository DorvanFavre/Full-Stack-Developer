import 'package:flutter/material.dart';

/// Created by D0rvan
/// 12.01.2021
/// v 1.0
///
///
class Delayed extends StatelessWidget {
  /// widget that will be built after the delay
  final Widget child;

  /// The duration befor the child is built
  final Duration delay;

  /// Delayed
  ///
  /// Build the child after a certain delay
  ///
  Delayed({@required this.child, this.delay = const Duration(seconds: 0)})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return child;
        } else
          return SizedBox.shrink();
      },
    );
  }
}
