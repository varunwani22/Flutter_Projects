import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initalHeight = birdYaxis;
  bool gameHasStarted = false;
  double gravity = -4.5;
  double velocity = 3.5;
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  // static double barrierXOne = 1;
  // double barrierXTwo = barrierXOne + 1.5;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // time += 0.05;
      height = gravity * time * time + velocity * time;

      setState(() {
        birdYaxis = initalHeight - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      moveMap();
      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initalHeight = birdYaxis;
    });
    barrierX = [2, 2 + 1.5];
    barrierWidth = 0.5;
    barrierHeight = [
      [0.6, 0.4],
      [0.4, 0.6],
    ];
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              'G A M E  O V E R',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  color: Colors.white,
                  child: const Text(
                    'Play Again',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initalHeight = birdYaxis;
    });
  }

  bool birdIsDead() {
    if (birdYaxis < -1 || birdYaxis > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdYaxis <= -1 + barrierHeight[i][0] ||
              birdYaxis + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        alignment: Alignment(0, birdYaxis),
                        duration: const Duration(milliseconds: 0),
                        child: MyBird(
                          birdYaxis: birdYaxis,
                          birdWidth: birdWidth,
                          birdHeight: birdHeight,
                        ),
                      ),
                      Container(
                        alignment: const Alignment(0, -0.3),
                        child: Visibility(
                          visible: !gameHasStarted,
                          child: const Text(
                            'T A P    T 0    P L A Y',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[0],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarriers(
                        barrierX: barrierX[1],
                        barrierwidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown[600],
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text(
                //           'Score',
                //           style: TextStyle(fontSize: 20, color: Colors.white),
                //         ),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         Text(
                //           '0',
                //           style: TextStyle(fontSize: 35, color: Colors.white),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         Text(
                //           'Best',
                //           style: TextStyle(fontSize: 20, color: Colors.white),
                //         ),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         Text(
                //           '10',
                //           style: TextStyle(fontSize: 35, color: Colors.white),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
