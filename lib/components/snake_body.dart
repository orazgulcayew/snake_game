import 'package:flutter/material.dart';

class SnakeBody extends StatelessWidget {
  const SnakeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
    );
  }
}
