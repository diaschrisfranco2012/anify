import 'package:flutter/material.dart';

import '../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool filled;
  final EdgeInsets padding;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 14,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 10),
        ],
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: 1.0,
      child: filled
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: const Color(
                  0xFF0D0F15,
                ),
                padding: padding,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                elevation: 8,
                shadowColor: AppColors.accent
                    .withValues(alpha: 0.35),
              ),
              child: child,
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: AppColors.accent
                      .withValues(alpha: 0.6),
                  width: 1.5,
                ),
                foregroundColor: AppColors.accent,
                padding: padding,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
              child: child,
            ),
    );
  }
}
