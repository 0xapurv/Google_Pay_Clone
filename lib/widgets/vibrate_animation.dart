import 'dart:math' as math;

import 'package:flutter/material.dart';

class VibrateAnimation extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  VibrateAnimation({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Transform.rotate(
          angle: 0.1 *
              math.sin(
                  4 * math.pi * Curves.easeOutQuart.transform(animation.value)),
          child: Transform.scale(
            scale: 1 +
                animation.value *
                    0.2 *
                    math.sin(
                        math.pi * Curves.easeInOut.transform(animation.value)),
            child: child,
          ),
        );
      },
    );
  }
}