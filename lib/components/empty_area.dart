import 'package:flutter/material.dart';

class EmptyArea extends StatelessWidget {
  const EmptyArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(2),
        color: Colors.grey[800],
      ),
    );
  }
}
