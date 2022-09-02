import 'dart:async';
import 'package:flappybird/barrier.dart';
import 'package:flappybird/helicopter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double helicopterY = 0;
  double initialPos = helicopterY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  double helicopterWidth = 0.1;
  double helicopterHeight = 0.1;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        helicopterY = initialPos - height;
      });

      if (helicopterDead()) {
        timer.cancel();
        _showDailogbox();
      }

      moveMap();

      time += 0.1;
    });
  }

  void moveMap(){
    for (int i = 0; i < barrierX.length; i++){
      setState(() {
        barrierX[i] -= 0.005;
      });

      if(barrierX[i] < -1.5){
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = helicopterY;
    });
  }

  bool helicopterDead() {
    if (helicopterY < -1 || helicopterY > 1) {
      return true;
    }
    for (int i =0; i < barrierX.length; i++){
      if (barrierX[i] <= barrierWidth &&
          barrierX[i] + barrierWidth >= - barrierWidth &&
          (helicopterY <= -1 + barrierHeight[i][0] ||
              helicopterY + helicopterHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      helicopterY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = helicopterY;
    });
  }

  void _showDailogbox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade300,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.grey,
                    child: Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          );
        });
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
              child: AnimatedContainer(
                alignment: Alignment(0,0),
                duration: Duration(milliseconds: 0),
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Stack(
                    children: [
                      MyHelicopter(
                        helicopterHeight: helicopterHeight,
                        helicopterWidth: helicopterWidth,
                        helicopterY: helicopterY,
                      ),
                      MyBarrier(barrierWidth: barrierWidth, barrierHeight: barrierHeight[0][0], barrierX: barrierX[0], isThisBottomBarrier: false),
                      MyBarrier(barrierWidth: barrierWidth, barrierHeight: barrierHeight[0][1], barrierX: barrierX[0], isThisBottomBarrier: true),
                      MyBarrier(barrierWidth: barrierWidth, barrierHeight: barrierHeight[1][0], barrierX: barrierX[1], isThisBottomBarrier: false),
                      MyBarrier(barrierWidth: barrierWidth, barrierHeight: barrierHeight[1][1], barrierX: barrierX[1], isThisBottomBarrier: true),

                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
