import 'dart:async';

import 'package:flutter/material.dart';

class ListScrollingAnimator extends StatefulWidget {
  /// A list or scrollview
  final Widget list;

  /// Add a stack with the widgets that need to be animated with the provided animationController
  final Widget Function(AnimationController controller) animatedBuilder;

  /// List Scrolling animator
  ///
  /// manage a AnimationController -> forward when scrolling, reverse after 500ms not scrolling
  /// 
  /// Wrap a list with this widget
  ///
  ListScrollingAnimator({@required this.list, @required this.animatedBuilder});

  @override
  _ListScrollingAnimatorState createState() => _ListScrollingAnimatorState();
}

class _ListScrollingAnimatorState extends State<ListScrollingAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  StreamSubscription _streamSubscription;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollNotification) {
                _trigger();
              }
              return false;
            },
            child: widget.list),
        widget.animatedBuilder(_animationController)
      ],
    );
  }

  void _trigger() {
    if (isRunning == false) {
      isRunning = true;
      _animationController.forward();
    }

    _streamSubscription?.cancel();

    _streamSubscription =
        Future.delayed(Duration(milliseconds: 200)).asStream().listen((event) {
      _animationController.reverse();
      isRunning = false;
    });
  }
}
