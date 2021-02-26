import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class HysteresisAnimationController {
  HysteresisAnimationController({@required TickerProvider vsync}) {
    animationController = AnimationController(
        vsync: vsync, duration: Duration(milliseconds: 500));
  }
  AnimationController animationController;
  StreamSubscription _streamSubscription;

  bool isRunning = false;

  void trigger() {
    if(isRunning == false) {
      isRunning = true;
      animationController.forward();
    }

    _streamSubscription?.cancel();

    _streamSubscription =
        Future.delayed(Duration(milliseconds: 500)).asStream().listen((event) {
      animationController.reverse();
      isRunning = false;
    });
  }

  void dispose() {
    animationController.dispose();
  }
}
