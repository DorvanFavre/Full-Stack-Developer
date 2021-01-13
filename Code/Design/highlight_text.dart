import 'package:flutter/material.dart';

/// Created by Dorvan Favre
/// 13.01.2021
/// V 1.1
///
///
class HighlightText extends StatefulWidget {
  /// Text to be displayed
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  /// Color when mouse enter the text
  final Color enableColor;

  /// Color when mouse exit the text
  final Color disableColor;

  /// How much the text grows on enter
  final double scale;

  /// the translation offset on enter
  final Offset offset;

  /// Duration of the animation
  final Duration duration;

  final void Function() onTap;

  /// HighlightText
  ///
  /// Make the text grow when the mouse enter
  ///
  HighlightText(
      {@required this.text,
      this.onTap,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.disableColor = Colors.white30,
      this.enableColor = Colors.white,
      this.scale = 1.3,
      this.offset = const Offset(0, 10),
      this.duration = const Duration(milliseconds: 350)})
      : assert(text != null);

  @override
  _HighlightTextState createState() => _HighlightTextState();
}

class _HighlightTextState extends State<HighlightText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  // 1.
  // Add animations variable
  Animation _scaleAnimation;
  Animation _colorAnimation;
  Animation _translationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    // 2.
    // Initialize the animations
    _scaleAnimation = Tween<double>(begin: 1, end: widget.scale).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCubic));

    _colorAnimation =
        ColorTween(begin: widget.disableColor, end: widget.enableColor).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOutCubic));

    _translationAnimation =
        Tween<Offset>(begin: Offset.zero, end: widget.offset).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _animationController.forward();
      },
      onExit: (event) {
        _animationController.reverse();
      },
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            // 3.
            // Add the animations to the text
            return Transform.translate(
              offset: _translationAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        color: _colorAnimation.value,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
