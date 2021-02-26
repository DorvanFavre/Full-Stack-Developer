import 'dart:math';

import 'package:flutter/material.dart';

/// WixList
/// Created by Dorvan
/// 15.01.2021
/// V1.0
///
///
class WixList extends StatefulWidget {
  /// List of children
  final List<Widget> children;

  /// WixList
  ///
  /// Add childrens on by one when scrolling 
  /// 
  /// The animation is handled internaly
  ///
  WixList({@required this.children}) : assert(children != null);

  @override
  _WixListState createState() => _WixListState();
}

class _WixListState extends State<WixList> {
  final _animatedListKey = GlobalKey<AnimatedListState>();
  List<Widget> displayedChildren = [

    // Bottom margin
    SizedBox(
      height: 300,
    )
  ];
  int displayedChildrenIndex = 0;

  @override
  void initState() {
    super.initState();

    // Add the first child
    WidgetsBinding.instance.addPostFrameCallback((_) => addItem());
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0) {
          addItem();
          return true;
        } else
          return false;
      },
      child: AnimatedList(
        key: _animatedListKey,
        scrollDirection: Axis.vertical,
        initialItemCount: displayedChildren.length,
        itemBuilder: (context, index, animation) {

          // Animate the child
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: Tween<double>(begin: 0, end: 1)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeInOutCubic))
                    .value,
                child: Transform.translate(
                    offset: Tween<Offset>(
                            begin: Offset(pow(-1, index) * 50, 0),
                            end: Offset.zero)
                        .animate(CurvedAnimation(
                            parent: animation, curve: Curves.easeInOutCubic))
                        .value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: displayedChildren[index],
                    )),
              );
            },
          );
        },
      ),
    );
  }

  // Add item to the displayedChildren list
  void addItem() {
    if (displayedChildrenIndex < widget.children.length) {
      displayedChildren.insert(
          displayedChildrenIndex, widget.children[displayedChildrenIndex]);
      _animatedListKey.currentState.insertItem(displayedChildrenIndex, duration: Duration(milliseconds: 1000));
      displayedChildrenIndex++;
    }
  }
}
