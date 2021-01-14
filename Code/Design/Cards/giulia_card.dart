import 'dart:ui';

import 'package:flutter/material.dart';

class GiuliaCard extends StatefulWidget {
  final void Function() onEnter;
  final void Function() onExit;
  final void Function() onTap;
  final IconData iconData;

  /// How much the text grows on enter
  final double scale;

  /// the translation offset on enter
  final Offset offset;

  /// Duration of the animation
  final Duration duration;

  GiuliaCard(
      {@required this.iconData,
      this.onEnter = _emptyFuction,
      this.onExit = _emptyFuction,
      this.onTap = _emptyFuction,
      this.scale = 1.3,
      this.offset = const Offset(0, -100),
      this.duration = const Duration(milliseconds: 350)})
      : assert(iconData != null);

  static void _emptyFuction() {}

  @override
  _GiuliaCardState createState() => _GiuliaCardState();
}

class _GiuliaCardState extends State<GiuliaCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation _scaleAnimation;
  Animation _translationAnimation;
  Animation _sygmaAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _scaleAnimation = Tween<double>(begin: 1, end: widget.scale).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCubic));

    _sygmaAnimation = Tween<double>(begin: 0, end: 5).animate(CurvedAnimation(
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
    // Gesture
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) {
          widget.onEnter();
          _animationController.forward();
        },
        onExit: (event) {
          widget.onExit();
          _animationController.reverse();
        },

        // Animations
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: _translationAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: BackdropFilter(

                    // Remove blure effect maybe
                    filter: ImageFilter.blur(
                        sigmaX: _sygmaAnimation.value,
                        sigmaY: _sygmaAnimation.value),

                    // Card Content
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          height: 300,
                          width: 200,
                          decoration: ShapeDecoration(
                              color: Colors.white10,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white60, width: 1),
                                  borderRadius: BorderRadius.circular(20))),
                          child: Center(
                              child: Icon(
                            widget.iconData,
                            color: Colors.white70,
                            size: 100,
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
