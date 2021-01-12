import 'package:flutter/material.dart';

/// Created by Dorvan
/// 12.01.2021
/// 
class ParadeText extends StatefulWidget {
  final List<String> texts;
  final double translation;
  final Duration duration;
  final bool repeat;
  final void Function() onEnd;

  /// Parade Text
  ///
  /// Give a list of string and we'll make then parade for you
  ///
  ///
  ParadeText(
      {@required this.texts,
      this.translation = 40,
      this.duration = const Duration(milliseconds: 4000),
      this.repeat = false,
      this.onEnd})
      : assert(texts != null);

  @override
  _ParadeTextState createState() => _ParadeTextState();
}

class _ParadeTextState extends State<ParadeText>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation opacityAnimation;
  Animation translateAnimation;

  int index = 0;

  @override
  void initState() {
    super.initState();

    //Instancie controller
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Instancie opacitiy animation
    opacityAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 1)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(1),
        weight: 60.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 20.0,
      )
    ]).animate(animationController);

    // Instancie translate animation
    translateAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: widget.translation, end: 0)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0),
        weight: 60.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: -widget.translation)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 20.0,
      )
    ]).animate(animationController);

    // Add animation controller logic
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        index++;
        if (index >= widget.texts.length && widget.repeat == true) {
          index = 0;
        }
        if (index < widget.texts.length) {
          setState(() {});
          animationController.forward(from: 0);
        } else {
          widget.onEnd();
        }
      }
    });

    // Start animation controller
    if (widget.texts.length > 0) {
      animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Opacity(
          opacity: opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, translateAnimation.value),
            child: child,
          ),
        );
      },
      child: Text(
        widget.texts[index],
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
