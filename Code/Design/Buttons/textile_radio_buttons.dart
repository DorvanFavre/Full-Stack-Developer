import 'dart:math' as math;

import 'package:app51_web_sandbox/models/mask.dart';
import 'package:flutter/material.dart';

class TextileRadioButton extends StatefulWidget {
  /// List of masks (buttons)
  final List<Mask> masks;

  /// when a button is selected
  final void Function(int pageIndex) onPageChange;

  /// TextileRadioButton
  ///
  ///
  TextileRadioButton({@required this.masks, this.onPageChange = emptyFunction});

  @override
  _TextileRadioButtonState createState() => _TextileRadioButtonState();

  static void emptyFunction(dynamic) {}
}

class _TextileRadioButtonState extends State<TextileRadioButton> {
  PageController _pageController;
  ValueNotifier<double> _pageNotifier;

  @override
  void initState() {
    super.initState();
    _pageNotifier = ValueNotifier(0);
    _pageController = PageController(viewportFraction: 0.25);
    _pageController.addListener(() {
      _pageNotifier.value = _pageController.page;
    });
  }

  @override
  void dispose() {
    _pageNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: PageView.builder(
        onPageChanged: (index) {
          widget.onPageChange(index);
        },
        controller: _pageController,
        itemCount: widget.masks.length,
        itemBuilder: (context, index) {
          final mask = widget.masks[index];

          // Animation
          return ValueListenableBuilder<double>(
            valueListenable: _pageNotifier,
            builder: (context, page, child) {
              return Opacity(
                opacity: math.max(1 - ((index - page).abs() * 0.5), 0),
                child: Transform.scale(
                    scale: math.max(1 - ((index - page).abs() * 0.5), 0.5),
                    child: child),
              );
            },

            // Item
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              },
              child: Container(
                decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    image: DecorationImage(
                        image: AssetImage(
                            'images/textiles/${mask.textilPath}.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          );
        },
      ),
    );
  }
}
