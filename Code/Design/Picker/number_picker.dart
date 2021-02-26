import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int initialValue;
  final void Function(int value) onValueChange;
  final int minValue;
  final int maxValue;

  NumberPicker(
      {this.initialValue = 0,
      this.onValueChange = emptyFunction,
      this.minValue = 0,
      this.maxValue = 10});

  @override
  _NumberPickerState createState() => _NumberPickerState();

  static void emptyFunction(dynamic) {}
}

class _NumberPickerState extends State<NumberPicker> {
  int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_drop_up_rounded),
          onPressed: () {
            setState(() {
              if (value < widget.maxValue) {
                value++;
                widget.onValueChange(value);
              }
            });
          },
        ),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down_rounded),
          onPressed: () {
            setState(() {
              if (value > widget.minValue) {
                value--;
                widget.onValueChange(value);
              }
            });
          },
        )
      ],
    );
  }
}
