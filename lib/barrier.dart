import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  MyBarrier({this.barrierWidth, this.barrierHeight, this.barrierX,
      required this.isThisBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
      isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.redAccent,
        width:  MediaQuery.of(context).size.width * barrierWidth / 2,
        height:  MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
