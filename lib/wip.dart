import 'package:flutter/material.dart';

class WorkInProgress extends StatelessWidget {
  final double insetval = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      "WORK IN PROGRESS ! ",
      textAlign: TextAlign.center,
      style: TextStyle(
          foreground: Paint()
            // ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Color(0xFFFF3B3B)),
    )));
  }
}
