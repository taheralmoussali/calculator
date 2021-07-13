import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final Function buttonTapped;
  Buttons({this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        color: color,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: textColor, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
