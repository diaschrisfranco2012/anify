import 'package:flutter/material.dart';

class AnimatedAnifyBackground
    extends StatefulWidget {
  final Widget child;
  const AnimatedAnifyBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedAnifyBackground> createState() =>
      _AnimatedAnifyBackgroundState();
}

class _AnimatedAnifyBackgroundState
    extends State<AnimatedAnifyBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 32),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        final t = _c.value;
        final begin = Alignment.lerp(
          Alignment.topLeft,
          Alignment.topRight,
          t,
        )!;
        // subtle oscillation of stops
        final stops = [
          0.0,
          (0.4 + 0.1 * t).clamp(0.0, 1.0),
          1.0,
        ];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF0B1020), // deep navy
                Color(0xFF3E4AA8), // indigo
                Color(
                  0xFF1F7AE0,
                ), // electric blue
              ],
              stops: stops,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.55, -0.8),
                radius: 1.0,
                colors: [
                  Color(0x12FFFFFF),
                  Color(0x00000000),
                ],
              ),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
