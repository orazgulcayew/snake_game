import 'package:flutter/material.dart';

class Apple extends StatelessWidget {
  const Apple({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.red,
      ),
    );
  }
}
