import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdYaxis;
  final double birdWidth;
  final double birdHeight;

  MyBird({this.birdYaxis, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    // return Image.asset('assets/images/bird.jpg');
    return Container(
      alignment: Alignment(1, (2 * birdYaxis + birdHeight) / (2 - birdHeight)),
      height: 60,
      width: 60,
      child: Image.asset(
        // 'assets/images/bird.jpg',
        'assets/images/bird_image.jpeg',
        width: MediaQuery.of(context).size.height * birdWidth / 0.5,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 1,
        fit: BoxFit.fill,
      ),
    );
  }
}
