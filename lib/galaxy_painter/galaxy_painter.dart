import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'galaxy_controller.dart';

class GalaxyPainter extends CustomPainter {
  final double time;
  final GalaxyController galaxyController;

  GalaxyPainter(this.time, this.galaxyController);

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    Paint paint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height / 2),
        size.width / 2,
        [Colors.black, Colors.deepPurple, Colors.blue, Colors.black],
        [0.0, 0.4, 0.7, 1.0],
        TileMode.clamp,
        // Matrix4.rotationZ(pi / 4).storage, // Rotational effect
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // // Core
    _drawCore(canvas, size);

    // // Spiral Arms
    // _drawSpiralArms(canvas, size);

    // // Random Stars
    _drawRandomStars(canvas);

    // Galaxy Dust
    _drawGalaxyDust(canvas);

    // Stars
    _drawStars(canvas);

    // Planets
    _drawPlanets(canvas);
  }

  void _drawCore(Canvas canvas, Size size) {
    Paint corePaint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height / 2),
        size.width / 6,
        [Colors.white, Colors.yellow.withOpacity(0.5), Colors.transparent],
        [0.0, 0.3, 1.0],
      );
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 6, corePaint);
  }

  void _drawSpiralArms(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double maxRadius = size.width / 2;
    int numberOfArms = 4;
    double angleStep = 2 * pi / numberOfArms;

    Paint armPaint = Paint();

    for (int i = 0; i < numberOfArms; i++) {
      double angleOffset = i * angleStep + time * 0.01; // Slow rotation
      Path path = Path();

      for (double r = 0; r < maxRadius; r += 0.5) {
        double angle = r / maxRadius * 4 * pi + angleOffset;
        double x = centerX + r * cos(angle);
        double y = centerY + r * sin(angle);

        if (r == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      armPaint.shader = ui.Gradient.linear(
        Offset(centerX, centerY),
        Offset(centerX + maxRadius * cos(angleOffset),
            centerY + maxRadius * sin(angleOffset)),
        [Colors.transparent, Colors.deepPurple.withOpacity(0.5)],
      );

      canvas.drawPath(path, armPaint);
    }
  }

  void _drawRandomStars(Canvas canvas) {
    for (var star in galaxyController.randomStars) {
      Paint starPaint = Paint()..color = star.color;
      canvas.drawCircle(star.position, star.radius, starPaint);
    }
  }

  void _drawGalaxyDust(Canvas canvas) {
    for (var dust in galaxyController.galaxyDust) {
      Paint dustPaint = Paint()..color = dust.color;
      canvas.drawCircle(dust.position, dust.radius, dustPaint);
    }
  }

  void _drawStars(Canvas canvas) {
    for (var star in galaxyController.stars) {
      Paint starPaint = Paint()..color = star.color;
      canvas.drawCircle(star.position, star.radius, starPaint);
    }
  }

  void _drawPlanets(Canvas canvas) {
    for (var planet in galaxyController.planets) {
      Paint planetPaint = Paint()..color = planet.color;
      canvas.drawCircle(planet.position, planet.radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GalaxyPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
