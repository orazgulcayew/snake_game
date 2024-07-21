import 'package:flutter/material.dart';
import 'package:snake_game/main.dart';

class SnakeHead extends StatelessWidget {
  const SnakeHead({super.key, required this.moving});
  final Moving moving;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[800],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: getBorderRadius(),
            color: Colors.white,
          ),
          child: RotatedBox(
            quarterTurns: getRotation(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.black),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 2,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  int getRotation() {
    if (moving == Moving.right) {
      return 0;
    } else if (moving == Moving.left) {
      return 2;
    } else if (moving == Moving.down) {
      return 1;
    } else {
      return 3;
    }
  }

  BorderRadius getBorderRadius() {
    if (moving == Moving.right) {
      return const BorderRadius.horizontal(right: Radius.circular(16));
    } else if (moving == Moving.left) {
      return const BorderRadius.horizontal(left: Radius.circular(16));
    } else if (moving == Moving.down) {
      return const BorderRadius.vertical(bottom: Radius.circular(16));
    } else {
      return const BorderRadius.vertical(top: Radius.circular(16));
    }
  }
}
