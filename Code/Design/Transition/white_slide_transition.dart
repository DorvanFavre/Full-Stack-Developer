import 'package:flutter/material.dart';

/// Created by Dorvan Favre
/// 13.01.2021
/// v 1.0

class WhiteSlideTransition extends PageRouteBuilder {
  /// Page to build
  final Widget newPage;

  /// Comming from : Offset(0,1) is from below, Offset(0,-1) is from above, Offset(1,0) is from right, Offset(-1,0) is from left,
  final Offset offset;

  WhiteSlideTransition(
      {@required this.newPage, this.offset = const Offset(0, 1)})
      : super(
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) {
              return newPage;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return Stack(
                children: [

                  // Transparent slide
                  SlideTransition(
                    position: Tween<Offset>(begin: offset, end: Offset.zero)
                        .animate(CurvedAnimation(
                            curve: Interval(0, 0.4, curve: Curves.easeInCubic),
                            parent: animation)),
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),

                  // white Slide
                  SlideTransition(
                    position: Tween<Offset>(begin: offset, end: Offset.zero)
                        .animate(CurvedAnimation(
                            curve: Interval(0, 0.7, curve: Curves.easeInCubic),
                            parent: animation)),
                    child: Container(
                      color: Colors.white70,
                    ),
                  ),

                  // New Screen slide
                  SlideTransition(
                    position: Tween<Offset>(begin: offset, end: Offset.zero)
                        .animate(CurvedAnimation(
                            curve: Interval(0.4, 1, curve: Curves.easeInCubic),
                            parent: animation)),
                    child: child,
                  ),
                ],
              );
            });
}
