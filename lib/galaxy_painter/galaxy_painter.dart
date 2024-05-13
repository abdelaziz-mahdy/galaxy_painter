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
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Stars
    _drawStars(canvas);
    // Spiral Arms
    _drawSpiralArms(canvas, size);
  }

  void _drawStars(Canvas canvas) {
    for (var star in galaxyController.stars) {
      Paint starPaint = Paint()..color = star.color;
      canvas.drawCircle(star.position, star.radius, starPaint);
    }
  }

  void _drawSpiralArms(Canvas canvas, Size size) {
    Paint armPaint = Paint()
      ..color = Colors.blue.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    int numberOfArms = 4;
    double angleStep = 2 * pi / numberOfArms;
    double maxRadius = size.width / 2;

    for (int i = 0; i < numberOfArms; i++) {
      double angleOffset = i * angleStep + time; // Animated offset
      Path path = Path();

      for (double r = 0; r < maxRadius; r += 0.5) {
        double angle =
            log(r + 1) * 2 * pi / maxRadius + angleOffset; // Logarithmic spiral
        double x = size.width / 2 + r * cos(angle);
        double y = size.height / 2 + r * sin(angle);

        if (r == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, armPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GalaxyPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
