import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_painter/galaxy_painter/galaxy_controller.dart';
import 'package:galaxy_painter/galaxy_painter/galaxy_painter.dart';
import 'package:galaxy_painter/threshold_value_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Galaxy Painter',
      home: GalaxyScreen(),
    );
  }
}

class GalaxyScreen extends StatefulWidget {
  const GalaxyScreen({super.key});

  @override
  _GalaxyScreenState createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State<GalaxyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ThresholdValueNotifier _thresholdValueNotifier;
  late GalaxyController _galaxyController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 60), // Slower rotation
    )..addListener(() {
        _thresholdValueNotifier.value = _controller.value * 100 * pi;
        _galaxyController.updateStarsAndPlanets(
           _thresholdValueNotifier.value); // Update stars and planets on each tick
      });
    _thresholdValueNotifier =
        ThresholdValueNotifier(0.0, 0); // Set your desired threshold here
    _galaxyController = GalaxyController(1000, 100, 200,
        0); // Initialize with 1000 stars, 100 planets, 200 random stars, and 500 galaxy dust particles
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galaxy Painter'),
      ),
      body: Center(
        child: ValueListenableBuilder<double>(
          valueListenable: _thresholdValueNotifier,
          builder: (context, value, child) {
            return CustomPaint(
              size: const Size(400, 400),
              painter: GalaxyPainter(value, _galaxyController),
            );
          },
        ),
      ),
    );
  }
}
