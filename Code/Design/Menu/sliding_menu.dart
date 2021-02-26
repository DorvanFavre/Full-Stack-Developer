import 'package:flutter/material.dart';

/// Sliding menu
///
/// v 1.0
///
class SlidingMenu extends StatefulWidget {
  final SlidingMenuController controller;

  SlidingMenu({@required this.controller});

  @override
  _SlidingMenuState createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu>
    with SingleTickerProviderStateMixin {
  final double menuWidth = 300;

  AnimationController _animationController;

  Animation _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Controller
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    // animation
    _slideAnimation =
        Tween<Offset>(begin: Offset(-menuWidth, 0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeOutCubic));

    // Listeners
    widget.controller.statesNotifier.addListener(() {
      switch (widget.controller.statesNotifier.value) {
        case SlidingMenuStates.OPEN:
          _animationController.forward();
          print('forward');
          break;
        case SlidingMenuStates.CLOSE:
          _animationController.reverse();
          break;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // animation
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: _slideAnimation.value,

            // Menu
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: menuWidth,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: ListView(
                    children: [
                      // back arrow
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          iconSize: 25,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            widget.controller.close();
                          },
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      ),

                      //Collection
                      menuItem('Nos collections', () {}),

                      menuItem('Nos type de masque', () {}),

                      menuItem('Sur commande', () {}),

                      // Contact
                      menuItem('Nous contacter', () {}),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SlidingMenuController {
  // public
  void open() {
    statesNotifier.value = SlidingMenuStates.OPEN;
  }

  void close() {
    statesNotifier.value = SlidingMenuStates.CLOSE;
  }

  // Private
  ValueNotifier<SlidingMenuStates> statesNotifier;

  SlidingMenuController() {
    statesNotifier = ValueNotifier(SlidingMenuStates.CLOSE);
  }

  dispose() {
    statesNotifier.dispose();
  }
}

enum SlidingMenuStates {
  OPEN,
  CLOSE,
}

// widgets
Widget menuItem(String text, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18, fontFamily: 'Quicksand', color: Colors.black87),
      ),
    ),
  );
}
