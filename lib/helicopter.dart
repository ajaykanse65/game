import 'package:flutter/material.dart';

class MyHelicopter extends StatelessWidget {
  MyHelicopter(
      {this.helicopterY,
      required this.helicopterWidth,
      required this.helicopterHeight});

  final helicopterY;
  final double helicopterWidth;
  final double helicopterHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
          0, (2 * helicopterY + helicopterHeight) / (2 - helicopterHeight)),
      child: Image.asset(
        'assets/helicopter.png',
        width: MediaQuery.of(context).size.height * helicopterWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * helicopterHeight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
