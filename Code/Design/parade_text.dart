import 'package:flutter/material.dart';

/// Created by Dorvan
/// 12.01.2021
///
class ParadeText extends StatefulWidget {
  /// The texts that will parade
  final List<String> texts;

  /// Thw widget that will be displayed
  final Widget Function(String text) itemBuilder;

  /// How long(pix) the text slides
  final double translation;

  /// Duration between two texts
  final Duration duration;

  /// if true, the parade will loop forever
  final bool repeat;

  /// trigger when all texts has been shown (only if repeate == false)
  final void Function() onEnd;

  /// Parade Text
  ///
  /// Give a list of string and we'll make then parade for you
  ///
  ///
  ParadeText(
      {@required this.texts,
      @required this.itemBuilder,
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
        if (index + 1 < widget.texts.length) {
          index++;
          setState(() {});
          animationController.forward(from: 0);
        } else {
          if (widget.repeat == true) {
            index = 0;
            setState(() {});
            animationController.forward(from: 0);
          } else {
            widget.onEnd();
          }
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
        child: widget.itemBuilder(widget.texts[index]));
  }
}
