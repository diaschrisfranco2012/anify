import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ConfidenceBar extends StatelessWidget {
  final double value; // 0..1
  const ConfidenceBar({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Container(
            height: 10,
            color: Colors.white.withValues(
              alpha: 0.08,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 600,
            ),
            height: 10,
            width:
                MediaQuery.of(
                  context,
                ).size.width *
                v,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.accent,
                  AppColors.accentGlow,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
