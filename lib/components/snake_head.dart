import 'package:flutter/material.dart';

class SnakeHead extends StatelessWidget {
  const SnakeHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
    );
  }
}
