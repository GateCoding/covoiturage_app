import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String icon;
  final Function() onTap;
  const CircleButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFFEECE9),
          shape: BoxShape.circle,
        ),
        child: Image.asset(icon, width: 18),
      ),
    );
  }
}
