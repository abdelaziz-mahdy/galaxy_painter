import 'package:flutter/material.dart';
import 'dart:math';

class Star {
  Offset position;
  double initialAngle;
  double initialRadius;
  double z;
  Color color;
  double radius;

  Star(this.position, this.initialAngle, this.initialRadius, this.z, this.color,
      this.radius);
}

class GalaxyController {
  List<Star> stars = [];
  List<Star> planets = [];
  List<Star> randomStars = [];
  List<Star> galaxyDust = [];
  final int starCount;
  final int planetCount;
  final int randomStarCount;
  final int galaxyDustCount;
  final Random random = Random();

  GalaxyController(this.starCount, this.planetCount, this.randomStarCount,
      this.galaxyDustCount) {
    _generateStarsAndPlanets();
  }

  void _generateStarsAndPlanets() {
    _generateRandomStars(randomStarCount, 400, 400);
    _generateGalaxyDust(galaxyDustCount, 400, 400);
    _generateSpiralStars(starCount, 4, 400, 400);
    _generateSpiralPlanets(planetCount, 4, 400, 400);
  }

  void _generateRandomStars(int count, double width, double height) {
    for (int i = 0; i < count; i++) {
      double x = random.nextDouble() * width;
      double y = random.nextDouble() * height;
      double z = random.nextDouble();
      double radius = random.nextDouble() * 1.5 * (1 - z);
      int alpha = (100 + (156 * (1 - z)).toInt());
      Color color = Color.fromARGB(alpha, 255, 255, 255);

      randomStars.add(Star(Offset(x, y), random.nextDouble() * 2 * pi, 0, z, color, radius));
    }
  }

  void _generateGalaxyDust(int count, double width, double height) {
    for (int i = 0; i < count; i++) {
      double x = random.nextDouble() * width;
      double y = random.nextDouble() * height;
      double z = random.nextDouble();
      double radius = random.nextDouble() * 3 * (1 - z);
      int alpha = (50 + (100 * (1 - z)).toInt());
      Color color = Color.fromARGB(alpha, 139, 69, 19); // Brownish color for dust

      galaxyDust.add(Star(Offset(x, y), 0, 0, z, color, radius));
    }
  }

  void _generateSpiralStars(int count, int arms, double width, double height) {
    double centerX = width / 2;
    double centerY = height / 2;
    double maxRadius = width / 2;
    double angleStep = 2 * pi / arms;

    for (int i = 0; i < arms; i++) {
      double angleOffset = i * angleStep;

      for (int j = 0; j < count / arms; j++) {
        double r = sqrt(random.nextDouble()) * maxRadius;
        double angle = r / maxRadius * 4 * pi + angleOffset; // Spiral angle calculation
        double x = centerX + r * cos(angle);
        double y = centerY + r * sin(angle);
        double z = random.nextDouble();
        double radius = random.nextDouble() * 1.5 * (1 - z);
        int alpha = (100 + (156 * (1 - z)).toInt());
        Color color = Color.fromARGB(alpha, 255, 255, 255);

        stars.add(Star(Offset(x, y), angle, r, z, color, radius));
      }
    }
  }

  void _generateSpiralPlanets(int count, int arms, double width, double height) {
    double centerX = width / 2;
    double centerY = height / 2;
    double maxRadius = width / 2;
    double angleStep = 2 * pi / arms;

    for (int i = 0; i < arms; i++) {
      double angleOffset = i * angleStep;

      for (int j = 0; j < count / arms; j++) {
        double r = sqrt(random.nextDouble()) * maxRadius;
        double angle = r / maxRadius * 4 * pi + angleOffset; // Spiral angle calculation
        double x = centerX + r * cos(angle);
        double y = centerY + r * sin(angle);
        double z = random.nextDouble();
        double radius = (random.nextDouble() * 3 + 2) * (1 - z); // Larger radius for planets in foreground
        int alpha = (200 + (55 * (1 - z)).toInt());
        Color color = Color.fromARGB(alpha, random.nextInt(256), random.nextInt(256), random.nextInt(256));

        planets.add(Star(Offset(x, y), angle, r, z, color, radius));
      }
    }
  }

  void updateStarsAndPlanets(double time) {
    double centerX = 200; // Assuming a fixed size of 400x400
    double centerY = 200;

    // Update spiral stars to move in circular pattern
    for (var star in stars) {
      double angle = star.initialAngle + time; // Slow movement
      double x = centerX + star.initialRadius * cos(angle);
      double y = centerY + star.initialRadius * sin(angle);
      star.position = Offset(x, y);

      // Make stars dim and lighten randomly
      int alpha = (100 + random.nextInt(156)).toInt();
      star.color = Color.fromARGB(alpha, 255, 255, 255);
    }

    // Update random stars to twinkle
    for (var star in randomStars) {
      // Make stars dim and lighten randomly
      int alpha = (100 + random.nextInt(156)).toInt();
      star.color = Color.fromARGB(alpha, 255, 255, 255);
    }

    // Update planets to move in circular pattern
    for (var planet in planets) {
      double angle = planet.initialAngle + time; // Even slower movement
      double x = centerX + planet.initialRadius * cos(angle);
      double y = centerY + planet.initialRadius * sin(angle);
      planet.position = Offset(x, y);
    }
  }
}

