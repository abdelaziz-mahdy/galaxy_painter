import 'dart:math';

import 'package:flutter/material.dart';
import 'package:galaxy_painter/galaxy_painter/galaxy_controller.dart';
import 'package:galaxy_painter/galaxy_painter/galaxy_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_painter/galaxy_painter/star.dart';
import 'package:galaxy_painter/threshold_value_notifier.dart';

import 'package:flutter/material.dart';
import 'package:galaxy_painter/galaxy_painter/galaxy_painter.dart';
import 'package:galaxy_painter/threshold_value_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy Painter',
      home: GalaxyScreen(),
    );
  }
}

class GalaxyScreen extends StatefulWidget {
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
      duration: Duration(minutes: 60), // Slower rotation
    )..addListener(() {
        _thresholdValueNotifier.value = _controller.value * 2 * pi;
        _galaxyController.updateStars(); // Update stars on each tick
      });
    _thresholdValueNotifier =
        ThresholdValueNotifier(0.0, 0.0005); // Set your desired threshold here
    _galaxyController = GalaxyController(1000); // Initialize with 1000 stars
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
        title: Text('Galaxy Painter'),
      ),
      body: Center(
        child: ValueListenableBuilder<double>(
          valueListenable: _thresholdValueNotifier,
          builder: (context, value, child) {
            return CustomPaint(
              size: Size(400, 400),
              painter: GalaxyPainter(value, _galaxyController),
            );
          },
        ),
      ),
    );
  }
}
