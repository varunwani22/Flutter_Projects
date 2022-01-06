import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final barrierwidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  MyBarriers({
    this.barrierHeight,
    this.barrierwidth,
    required this.isThisBottomBarrier,
    this.barrierX,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierwidth) / (2 - barrierwidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierwidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
