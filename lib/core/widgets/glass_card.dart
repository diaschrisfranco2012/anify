import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 16,
                sigmaY: 16,
              ),
              child: const SizedBox(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(radius),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(
                      alpha: 0.26,
                    ),
                    Colors.white.withValues(
                      alpha: 0.20,
                    ),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.75,
                  ),
                  width: 1,
                ),
              ),
              padding: padding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
