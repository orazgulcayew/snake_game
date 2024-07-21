import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/components/apple.dart';
import 'package:snake_game/components/empty_area.dart';
import 'package:snake_game/components/snake_body.dart';
import 'package:snake_game/components/snake_head.dart';

enum Moving { right, left, down, up }

void main() {
  runApp(const SnakeGame());
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              brightness: Brightness.dark,
            )),
        home: const GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const gameAreaSize = 100;
  static const rowSize = 10;

  List<int> snakePosition = [0, 1, 2];
  int applePosition = 65;
  bool isGameRunning = false;
  Moving moving = Moving.right;
  int score = 0;

  handleStartAndStop() {
    setState(() {
      isGameRunning = !isGameRunning;
    });

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (isGameRunning) {
          if (!gameOver()) {
            moveSnake();
          } else {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.black,
                surfaceTintColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.green, width: 1)),
                title: const Text("Game over!"),
                content: Text('Your score is $score'),
                actions: [
                  TextButton(
                      onPressed: () {
                        handleStartAndStop();
                        Navigator.pop(context);
                      },
                      child: const Text('Restart'))
                ],
              ),
            );
            timer.cancel();
          }
        } else {
          restartGame();
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 && moving != Moving.up) {
            setState(() {
              moving = Moving.down;
            });
          }
          if (details.delta.dy < 0 && moving != Moving.down) {
            setState(() {
              moving = Moving.up;
            });
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && moving != Moving.left) {
            setState(() {
              moving = Moving.right;
            });
          }
          if (details.delta.dx < 0 && moving != Moving.right) {
            setState(() {
              moving = Moving.left;
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Score"),
                  Text(
                    "$score",
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            crossAxisCount: rowSize),
                    itemCount: gameAreaSize,
                    itemBuilder: (context, index) {
                      // return Text(index.toString());

                      if (snakePosition.last == index) {
                        return SnakeHead(moving: moving);
                      }
                      if (snakePosition.contains(index)) {
                        return const SnakeBody();
                      }

                      if (applePosition == index) {
                        return const Apple();
                      }

                      return const EmptyArea();
                    })),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                      onPressed: () {
                        handleStartAndStop();
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: isGameRunning ? Colors.red : null),
                      child: Text(
                        isGameRunning ? "Restart" : "Start",
                        style: TextStyle(
                            color: isGameRunning ? Colors.white : null),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void restartGame() {
    snakePosition = [0, 1, 2];
    applePosition = 45;
    score = 0;
    moving = Moving.right;
  }

  void moveSnake() {
    switch (moving) {
      case Moving.right:
        if (snakePosition.last % rowSize == 9) {
          snakePosition.add(snakePosition.last + 1 - rowSize);
        } else {
          snakePosition.add(snakePosition.last + 1);
        }

        break;
      case Moving.left:
        if (snakePosition.last % rowSize == 0) {
          snakePosition.add(snakePosition.last - 1 + rowSize);
        } else {
          snakePosition.add(snakePosition.last - 1);
        }

        break;
      case Moving.down:
        if (snakePosition.last ~/ rowSize == 9) {
          snakePosition.add(snakePosition.last + rowSize - gameAreaSize);
        } else {
          snakePosition.add(snakePosition.last + rowSize);
        }

        break;
      case Moving.up:
        if (snakePosition.last ~/ rowSize == 0) {
          snakePosition.add(snakePosition.last - rowSize + gameAreaSize);
        } else {
          snakePosition.add(snakePosition.last - rowSize);
        }

        break;
      default:
    }

    if (snakePosition.last != applePosition) {
      snakePosition.removeAt(0);
    } else {
      changeApplePosition();
    }
  }

  void changeApplePosition() {
    score++;

    while (snakePosition.contains(applePosition)) {
      applePosition = Random().nextInt(gameAreaSize);
    }
  }

  bool gameOver() {
    bool hasDuplicates = snakePosition.toSet().length != snakePosition.length;

    return hasDuplicates;
  }
}


// 24 25 26