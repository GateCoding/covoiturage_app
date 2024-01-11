import 'package:flutter/material.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillTeal => const BoxDecoration(
        color: Color(0XFF008955),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: const Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: const Color(0XFF000000).withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder10 => BorderRadius.circular(
        10,
      );
  static BorderRadius get circleBorder22 => BorderRadius.circular(
        22,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;
