import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/colors.dart';

class ActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ActionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 160,
        ),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withValues(
            alpha: 0.06,
          ),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.12,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 36,
              color: AppColors.accent,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helpers
  static IconData cameraIcon() =>
      Symbols.camera_rounded;
  static IconData galleryIcon() =>
      Symbols.photo_library_rounded;
}
