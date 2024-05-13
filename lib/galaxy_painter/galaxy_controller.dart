import 'dart:math';
import 'package:flutter/material.dart';
import 'package:galaxy_painter/galaxy_painter/star.dart';

class GalaxyController {
  List<Star> stars = [];
  final int starCount;
  final Random random = Random();

  GalaxyController(this.starCount) {
    _generateStars();
  }

  void _generateStars() {
    for (int i = 0; i < starCount; i++) {
      double x = random.nextDouble() * 400; // Assuming a fixed size
      double y = random.nextDouble() * 400;
      double radius = random.nextDouble() * 2;
      int alpha = (100 + random.nextInt(156)).toInt();
      Color color = Color.fromARGB(alpha, 255, 255, 255);

      stars.add(Star(Offset(x, y), color, radius));
    }
  }

  void updateStars() {
    // Implement any logic to update stars if necessary
    for (var star in stars) {
      // Example: Make stars twinkle by changing their alpha
      int alpha = (100 + random.nextInt(156)).toInt();
      star.color = Color.fromARGB(alpha, 255, 255, 255);
    }
  }
}
