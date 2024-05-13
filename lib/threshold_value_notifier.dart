import 'package:flutter/material.dart';

class ThresholdValueNotifier extends ValueNotifier<double> {
  final double threshold;
  double _previousValue;

  ThresholdValueNotifier(super.value, this.threshold) : _previousValue = value;

  @override
  set value(double newValue) {
    if ((newValue - _previousValue).abs() > threshold) {
      _previousValue = newValue;
      super.value = newValue;
    }
  }
}
