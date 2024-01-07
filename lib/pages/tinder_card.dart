import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final color;

  Card({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}