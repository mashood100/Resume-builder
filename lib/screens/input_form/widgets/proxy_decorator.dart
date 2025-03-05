import 'dart:ui';
import 'package:flutter/material.dart';

/// A decorator widget that adds a shadow and slight rotation to a widget being reordered.
Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(0, 6, animValue)!;
      return Transform.rotate(
        angle: lerpDouble(0, -0.025, animValue)!,
        child: Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      );
    },
    child: child,
  );
} 